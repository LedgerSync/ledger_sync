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
          oauth_client.authorization_url(redirect_uri: redirect_uri)
        end

        def find(path:)
          url = "#{oauth_base_uri}/#{path}"

          request(
            headers: OAUTH_HEADERS.dup,
            method: :get,
            url: url
          )
        end

        def oauth
          OAuth2::AccessToken.new(
            oauth_client.client,
            access_token,
            refresh_token: refresh_token
          )
        end

        def oauth_client
          @oauth_client ||= OAuthClient.new(
            client_id: client_id,
            client_secret: client_secret
          )
        end

        def post(path:, payload:)
          url = "#{oauth_base_uri}/#{path}"

          request(
            headers: OAUTH_HEADERS.dup,
            method: :post,
            body: payload,
            url: url
          )
        end

        def query(limit: 10, offset: 1, query:, resource_class:)
          ledger_resource_type = self.class.ledger_resource_type_for(
            resource_class: resource_class
          ).classify
          full_query = "SELECT * FROM #{ledger_resource_type} WHERE #{query} STARTPOSITION #{offset} MAXRESULTS #{limit}"
          url = "#{oauth_base_uri}/query?query=#{CGI.escape(full_query)}"

          request(
            headers: OAUTH_HEADERS.dup,
            method: :get,
            url: url
          )
        end

        def refresh!
          set_credentials_from_oauth_token(
            token: Request.new(
              adaptor: self
            ).refresh!
          )
          self
        end

        def revoke_token!
          headers = OAUTH_HEADERS.dup.merge('Authorization' => 'Basic ' + Base64.strict_encode64(client_id + ':' + client_secret))
          LedgerSync::Adaptors::Request.new(
            body: {
              token: access_token
            },
            headers: headers,
            method: :post,
            url: REVOKE_TOKEN_URI
          ).perform.status == 200
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

        def self.ledger_resource_type_overrides
          {
            LedgerSync::Expense => 'purchase',
            LedgerSync::LedgerClass => 'class'
          }
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

        def request(body: nil, headers: {}, method:, url:)
          Request.new(
            adaptor: self,
            body: body,
            headers: headers,
            method: method,
            url: url
          ).perform
        end

        def set_credentials_from_oauth_token(realm_id: nil, token:)
          @previous_access_tokens << access_token if access_token.present?
          @access_token = token.token

          @expires_at = Time&.at(token.expires_at.to_i)&.to_datetime
          @refresh_token_expires_at = Time&.at(Time.now.to_i + token.params['x_refresh_token_expires_in'])&.to_datetime unless token.params['x_refresh_token_expires_in'].nil?

          @previous_refresh_tokens << refresh_token if refresh_token.present?
          @refresh_token = token.refresh_token

          @realm_id = realm_id unless realm_id.nil?
        ensure
          update_secrets_in_dotenv if update_dotenv
        end
      end
    end
  end
end
