# frozen_string_literal: true

require_relative 'oauth_client'

module LedgerSync
  module Ledgers
    module Xero
      class Client < ::LedgerSync::Ledgers::Client
        ROOT_URI = 'https://api.xero.com/api.xro/2.0'
        OAUTH_HEADERS = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }.freeze
        
        attr_reader :access_token,
                    :client_id,
                    :client_secret,
                    :expires_at,
                    :previous_refresh_tokens,
                    :refresh_token,
                    :refresh_token_expires_at,
                    :tenant_id,
                    :root_uri,
                    :update_dotenv

        def initialize(
          access_token:,
          client_id:,
          client_secret:,
          refresh_token:,
          tenant_id:,
          update_dotenv: true
        )
          @access_token = access_token
          @client_id = client_id
          @client_secret = client_secret
          @refresh_token = refresh_token
          @update_dotenv = update_dotenv
          @tenant_id = tenant_id

          @previous_access_tokens = []
          @previous_refresh_tokens = []

          @root_uri = ROOT_URI

          update_secrets_in_dotenv if update_dotenv
        end

        def authorization_url(redirect_uri:)
          oauth_client.authorization_url(redirect_uri: redirect_uri)
        end

        def find(path:)
          url = "#{ROOT_URI}/#{path.capitalize}"

          request(
            headers: oauth_headers,
            method: :get,
            url: url
          )
        end

        def post(path:, payload:)
          url = "#{ROOT_URI}/#{path.capitalize}"

          request(
            headers: oauth_headers,
            method: :post,
            body: {
              path.capitalize => payload
            },
            url: url
          )
        end

        def oauth_headers
          OAUTH_HEADERS.dup.merge('Xero-tenant-id' => @tenant_id)
        end

        def oauth
          OAuth2::AccessToken.new(
            oauth_client.client,
            access_token,
            refresh_token: refresh_token
          )
        end

        def oauth_client
          @oauth_client ||= LedgerSync::Ledgers::Xero::OAuthClient.new(
            client_id: client_id,
            client_secret: client_secret
          )
        end

        def refresh!
          set_credentials_from_oauth_token(
            token: Request.new(
              client: self
            ).refresh!
          )
          self
        end

        def tenants
          response = oauth.get(
            '/connections',
            body: nil,
            headers: LedgerSync::Ledgers::Xero::Client::OAUTH_HEADERS.dup
          )
          JSON.parse(response.body)
        end

        def request(body: nil, headers: {}, method:, url:)
          Request.new(
            client: self,
            body: body,
            headers: headers,
            method: method,
            url: url
          ).perform
        end

        def self.new_from_env(**override)
          new(
            {
              access_token: ENV.fetch('ACCESS_TOKEN'),
              client_id: ENV.fetch('CLIENT_ID'),
              client_secret: ENV.fetch('CLIENT_SECRET'),
              refresh_token: ENV.fetch('REFRESH_TOKEN'),
              tenant_id: ENV.fetch('TENANT_ID')
            }.merge(override)
          )
        end

        def set_credentials_from_oauth_code(code:, redirect_uri:)
          oauth_token = oauth_client.get_token(
            code: code,
            redirect_uri: redirect_uri
          )

          set_credentials_from_oauth_token(
            token: oauth_token
          )

          oauth_token
        end

        def set_credentials_from_oauth_token(token:) # rubocop:disable Metrics/CyclomaticComplexity,Naming/AccessorMethodName
          @previous_access_tokens << access_token if access_token.present?
          @access_token = token.token

          @expires_at = Time&.at(token.expires_at.to_i)&.to_datetime
          unless token.params['x_refresh_token_expires_in'].nil?
            @refresh_token_expires_at = Time&.at(
              Time.now.to_i + token.params['x_refresh_token_expires_in']
            )&.to_datetime
          end

          @previous_refresh_tokens << refresh_token if refresh_token.present?
          @refresh_token = token.refresh_token
        ensure
          update_secrets_in_dotenv if update_dotenv
        end

        def update_secrets_in_dotenv
          return if ENV['TEST_ENV'] && !ENV['USE_DOTENV_ADAPTOR_SECRETS']

          filename = File.join(Dir.pwd, '.env')
          return unless File.exist?(filename)

          Tempfile.open(".#{File.basename(filename)}", File.dirname(filename)) do |tempfile|
            File.open(filename).each do |line|
              env_key = line.split('=').first
              client_method = env_key.downcase

              if respond_to?(client_method)
                env_value = ENV[env_key]
                new_value = send(client_method)
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
      end
    end
  end
end
