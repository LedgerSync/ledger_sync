# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Xero
      class OAuthClient
        AUTHORIZE_URL = 'https://login.xero.com/identity/connect/authorize'
        RESPONSE_TYPE = 'code'
        SITE_URL = 'https://api.xero.com/api.xro/2.0'
        TOKEN_URL = 'https://identity.xero.com/connect/token'
        SCOPE = %w[
          offline_access
          openid
          profile
          email
          accounting.transactions
          accounting.contacts
        ]
        
        class RedirectURIParser
          attr_reader :uri

          def initialize(uri:)
            @uri = uri
          end

          def code
            @code ||= query.fetch('code').first
          end

          def parsed_uri
            @parsed_uri = URI.parse(uri)
          end

          def query
            @query ||= CGI.parse(parsed_uri.query)
          end

          def realm_id
            @realm_id ||= query.fetch('realmId').first
          end

          def redirect_uri
            @redirect_uri ||= begin
              use_uri = parsed_uri.dup
              use_uri.fragment = nil
              use_uri.query = nil
              ret = use_uri.to_s
              ret = ret[0..-2] if ret.end_with?('/')
              ret
            end
          end
        end

        attr_reader :client_id,
                    :client_secret

        def initialize(client_id:, client_secret:)
          @client_id = client_id
          @client_secret = client_secret
        end

        def authorization_url(redirect_uri:)
          client.auth_code.authorize_url(
            redirect_uri: redirect_uri,
            response_type: RESPONSE_TYPE,
            state: SecureRandom.hex(12),
            scope: SCOPE.join(' ')
          )
        end

        def auth_code
          client.auth_code
        end

        def client
          @client ||= OAuth2::Client.new(
            client_id,
            client_secret,
            authorize_url: AUTHORIZE_URL,
            site: SITE_URL,
            token_url: TOKEN_URL
          )
        end

        def get_token(code:, redirect_uri:)
          auth_code.get_token(
            code,
            redirect_uri: redirect_uri
          )
        end

        def self.new_from_env
          new(
            client_id: ENV.fetch('CLIENT_ID'),
            client_secret: ENV.fetch('CLIENT_SECRET')
          )
        end
      end
    end
  end
end
