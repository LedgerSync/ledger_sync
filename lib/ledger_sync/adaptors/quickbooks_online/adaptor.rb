# frozen_string_literal: true

require_relative 'oauth_client'
require_relative 'dashboard_url_helper'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class Adaptor < LedgerSync::Adaptors::Adaptor
        OAUTH_HEADERS     = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }.freeze
        ROOT_URI          = 'https://quickbooks.api.intuit.com'
        REVOKE_TOKEN_URI  = 'https://developer.api.intuit.com/v2/oauth2/tokens/revoke'
        ROOT_SANDBOX_URI  = 'https://sandbox-quickbooks.api.intuit.com'

        attr_reader :access_token,
                    :client_id,
                    :client_secret,
                    :expires_at,
                    :previous_access_tokens,
                    :previous_refresh_tokens,
                    :realm_id,
                    :refresh_token,
                    :refresh_token_expires_at,
                    :root_uri,
                    :test,
                    :update_dotenv

        def initialize(
          access_token:,
          client_id:,
          client_secret:,
          realm_id:,
          refresh_token:,
          test: false,
          update_dotenv: true
        )
          @access_token = access_token
          @client_id = client_id
          @client_secret = client_secret
          @realm_id = realm_id
          @refresh_token = refresh_token
          @test = test
          @update_dotenv = update_dotenv

          @previous_access_tokens = []
          @previous_refresh_tokens = []

          @root_uri = (test ? ROOT_SANDBOX_URI : ROOT_URI)

          update_secrets_in_dotenv if update_dotenv
        end

        def authorization_url(redirect_uri:)
          oauth_client.authorize_url(redirect_uri: redirect_uri)
        end

        def find(resource:, id:)
          resource = resource.to_s
          url = "#{oauth_base_uri}/#{resourcify(resource)}/#{id}"

          response = request(:get, url, headers: OAUTH_HEADERS.dup)
          JSON.parse(response.body).dig(resource.classify)
        end

        def parse_operation_error(error:, operation:)
          return nil unless error.is_a?(OAuth2::Error)

          Util::OperationErrorParser.new(
            error: error,
            operation: operation
          ).parse
        end

        def post(resource:, payload:)
          resource = resource.to_s
          url = "#{oauth_base_uri}/#{resourcify(resource)}"

          response = request(
            :post,
            url,
            headers: OAUTH_HEADERS.dup,
            body: payload.to_json
          )
          JSON.parse(response.body).dig(resource.classify)
        end

        def query(resource:, query:, limit: 10, offset: 1)
          resource = resource.to_s
          full_query = "SELECT * FROM #{resource.classify} WHERE #{query} STARTPOSITION #{offset} MAXRESULTS #{limit}"
          url = "#{oauth_base_uri}/query?query=#{CGI.escape(full_query)}"

          response = request(:get, url, headers: OAUTH_HEADERS.dup)
          JSON.parse(response.body).dig('QueryResponse', resource.classify) || []
        end

        def refresh!
          set_credentials_from_oauth_token(token: oauth.refresh!)
          self
        rescue OAuth2::Error => e
          raise parse_error(error: e)
        end

        def revoke_token!
          request(
            :post,
            REVOKE_TOKEN_URI,
            body: {
              token: access_token
            }.to_json,
            headers: OAUTH_HEADERS.dup
          ).status == 200
        end

        def set_credentials_from_oauth_code(code:, realm_id: nil, redirect_uri:)
          oauth_token = oauth_client.get_token(
            code: code,
            redirect_uri: redirect_uri
          )

          set_credentials_from_oauth_token(
            realm_id: realm_id,
            token: oauth_token
          )

          oauth_token
        end

        def update_secrets_in_dotenv
          return if ENV['TEST_ENV'] && !ENV['USE_DOTENV_ADAPTOR_SECRETS']

          filename = File.join(LedgerSync.root, '.env')
          return unless File.exist?(filename)

          prefix = 'QUICKBOOKS_ONLINE_'

          Tempfile.open(".#{File.basename(filename)}", File.dirname(filename)) do |tempfile|
            File.open(filename).each do |line|
              env_key = line.split('=').first
              adaptor_method = env_key.split(prefix).last.downcase

              if line =~ /\A#{prefix}/ && respond_to?(adaptor_method)
                env_value = ENV[env_key]
                new_value = send(adaptor_method)
                tempfile.puts "#{env_key}=#{new_value}"
                next if env_value == new_value

                ENV[env_key] = new_value
                tempfile.puts "# #{env_key}=#{env_value} # Updated on #{Time.now}"
              else
                tempfile.puts line
              end
            end
            tempfile.close
            FileUtils.mv tempfile.path, filename
          end

          Dotenv.load
        end

        def url_for(resource:)
          DashboardURLHelper.new(resource: resource, test: test).url
        end

        def self.ledger_attributes_to_save
          %i[access_token expires_at refresh_token refresh_token_expires_at]
        end

        def self.new_from_env(**override)
          new(
            {
              access_token: ENV.fetch('QUICKBOOKS_ONLINE_ACCESS_TOKEN'),
              client_id: ENV.fetch('QUICKBOOKS_ONLINE_CLIENT_ID'),
              client_secret: ENV.fetch('QUICKBOOKS_ONLINE_CLIENT_SECRET'),
              realm_id: ENV.fetch('QUICKBOOKS_ONLINE_REALM_ID'),
              refresh_token: ENV.fetch('QUICKBOOKS_ONLINE_REFRESH_TOKEN')
            }.merge(override)
          )
        end

        def self.new_from_oauth_client_uri(oauth_client:, uri:, **override)
          parsed_uri = OAuthClient::RedirectURIParser.new(uri: uri)
          oauth_token = oauth_client.get_token(
            code: parsed_uri.code,
            redirect_uri: parsed_uri.redirect_uri
          )

          new(
            {
              access_token: oauth_token.token,
              client_id: oauth_client.client_id,
              client_secret: oauth_client.client_secret,
              realm_id: parsed_uri.realm_id,
              refresh_token: oauth_token.refresh_token
            }.merge(override)
          )
        end

        private

        def oauth_base_uri
          @oauth_base_uri ||= "#{root_uri}/v3/company/#{realm_id}"
        end

        def oauth(force: false)
          if @oauth.nil? || force
            @oauth = OAuth2::AccessToken.new(
              oauth_client.client,
              access_token,
              refresh_token: refresh_token
            )
          end

          @oauth
        end

        def oauth_client
          @oauth_client ||= OAuthClient.new(
            client_id: client_id,
            client_secret: client_secret
          )
        end

        def request(method, *args)
          oauth.send(method, *args)
        rescue OAuth2::Error => e
          error = parse_error(error: e) || parse_operation_error(error: e, operation: nil) || e

          raise error unless error.is_a?(Error::AdaptorError::AuthenticationError)

          begin
            refresh!
            oauth.send(method, *args)
          rescue OAuth2::Error => e
            raise parse_error(error: e) || e
          end
        end

        def parse_error(error:)
          Util::AdaptorErrorParser.new(
            error: error,
            adaptor: self
          ).parse
        end

        def resourcify(str)
          str.tr('_', '')
        end

        def set_credentials_from_oauth_token(realm_id: nil, token:)
          @previous_access_tokens << access_token if access_token.present?
          @access_token = token.token

          @expires_at = Time&.at(token.expires_at.to_i)&.to_datetime
          @refresh_token_expires_at = Time&.at(Time.now.to_i + token.params['x_refresh_token_expires_in'])&.to_datetime unless token.params['x_refresh_token_expires_in'].nil?

          @previous_refresh_tokens << refresh_token if refresh_token.present?
          @refresh_token = token.refresh_token

          @realm_id = realm_id unless realm_id.nil?

          update_secrets_in_dotenv if update_dotenv

          oauth(force: true) # Ensure we update the memoized @oauth
        end
      end
    end
  end
end
