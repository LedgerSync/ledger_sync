# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class OAuthClient
        AUTHORIZE_URL     = 'https://appcenter.intuit.com/connect/oauth2'
        SITE_URL          = 'https://appcenter.intuit.com/connect/oauth2'
        TOKEN_URL         = 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer'

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
            response_type: 'code',
            state: SecureRandom.hex(12),
            scope: 'com.intuit.quickbooks.accounting'
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
            client_id: ENV.fetch('QUICKBOOKS_ONLINE_CLIENT_ID'),
            client_secret: ENV.fetch('QUICKBOOKS_ONLINE_CLIENT_SECRET')
          )
        end
      end
    end
  end
end
