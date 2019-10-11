require 'oauth2'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class Adaptor < LedgerSync::Adaptors::Adaptor
        AUTHORIZE_URL     = 'https://appcenter.intuit.com/connect/oauth2'.freeze
        OAUTH_HEADERS     = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }.freeze
        ROOT_URI          = 'https://quickbooks.api.intuit.com'.freeze
        ROOT_SANDBOX_URI  = 'https://sandbox-quickbooks.api.intuit.com'.freeze
        SITE_URL          = 'https://appcenter.intuit.com/connect/oauth2'.freeze
        TOKEN_URL         = 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer'.freeze

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
                    :test

        def initialize(
          access_token:,
          client_id:,
          client_secret:,
          realm_id:,
          refresh_token:,
          test: false
        )
          @access_token = access_token
          @client_id = client_id
          @client_secret = client_secret
          @previous_access_tokens = []
          @previous_refresh_tokens = []
          @realm_id = realm_id
          @refresh_token = refresh_token
          @test = test

          @root_uri = (test ? ROOT_SANDBOX_URI : ROOT_URI)
        end

        def find(resource:, id:)
          url = "#{oauth_base_uri}/#{underscore(resource)}/#{id}"

          response = request(:get, url, headers: OAUTH_HEADERS.dup)
          JSON.parse(response.body).dig(resource.capitalize)
        end

        def parse_operation_error(error:, operation:)
          return nil unless error.kind_of?(OAuth2::Error)

          Util::OperationErrorParser.new(
            error: error,
            operation: operation
          ).parse
        end

        def post(resource:, payload:)
          url = "#{oauth_base_uri}/#{underscore(resource)}"

          response = request(:post, url, headers: OAUTH_HEADERS.dup, body: payload.to_json)
          JSON.parse(response.body).dig(resource.capitalize)
        end

        def query(resource:, query:, limit: 10, offset: 1)
          full_query = "SELECT * FROM #{resource.capitalize} WHERE #{query} STARTPOSITION #{offset} MAXRESULTS #{limit}"
          url = "#{oauth_base_uri}/query?query=#{CGI.escape(full_query)}"

          response = request(:get, url, headers: OAUTH_HEADERS.dup)
          JSON.parse(response.body).dig('QueryResponse', resource.capitalize) || []
        end

        def refresh!
          refreshed = oauth.refresh!

          @previous_access_tokens << access_token
          @access_token = refreshed.token

          @expires_at = Time&.at(refreshed.expires_at.to_i)&.to_datetime
          @refresh_token_expires_at = Time&.at(Time.now.to_i + refreshed.params['x_refresh_token_expires_in'])&.to_datetime

          @previous_refresh_tokens << refresh_token
          @refresh_token = refreshed.refresh_token

          oauth(force: true) # Ensure we update the memoized @oauth

          self
        rescue OAuth2::Error => e
          raise parse_error(error: e)
        end

        def self.ledger_attributes_to_save
          %i[access_token expires_at refresh_token refresh_token_expires_at]
        end

        # def self.url_for(resource:)
        #   case resource
        #   when Customer
        #     # TODO: How can we get the proper URL?  In dev, a random sandbox is used.
        #   end
        # end

        private

        def oauth_base_uri
          @oauth_base_uri ||= "#{root_uri}/v3/company/#{realm_id}"
        end

        def underscore(str)
          LedgerSync::Util::StringHelpers.underscore(str)
        end

        def oauth(force: false)
          if @oauth.nil? || force
            @oauth = OAuth2::AccessToken.new(
              oauth_client,
              access_token,
              refresh_token: refresh_token
            )
          end

          @oauth
        end

        def oauth_client
          @oauth_client ||= OAuth2::Client.new(
            client_id,
            client_secret,
            authorize_url: AUTHORIZE_URL,
            site: SITE_URL,
            token_url: TOKEN_URL
          )
        end

        def request(method, *args)
          oauth.send(method, *args)
        rescue OAuth2::Error => e
          error = parse_error(error: e)
          raise (error || e) unless error.is_a?(Error::AdaptorError::AuthenticationError)

          begin
            refresh!
            oauth.send(method, *args)
          rescue OAuth2::Error => e2
            raise parse_error(error: e2) || e2
          end
        end

        def parse_error(error:)
          Util::AdaptorErrorParser.new(
            error: error,
            adaptor: self
          ).parse
        end
      end
    end
  end
end
