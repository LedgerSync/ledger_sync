# frozen_string_literal: true

require 'oauth2'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class Adaptor < LedgerSync::Adaptors::Adaptor
        AUTHORIZE_URL     = 'https://appcenter.intuit.com/connect/oauth2'
        OAUTH_HEADERS     = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }.freeze
        ROOT_URI          = 'https://quickbooks.api.intuit.com'
        REVOKE_TOKEN_URI  = 'https://developer.api.intuit.com/v2/oauth2/tokens/revoke'
        ROOT_SANDBOX_URI  = 'https://sandbox-quickbooks.api.intuit.com'
        SITE_URL          = 'https://appcenter.intuit.com/connect/oauth2'
        TOKEN_URL         = 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer'

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

        def authorization_url(redirect_uri:)
          oauth_client.auth_code.authorize_url(
            redirect_uri: redirect_uri,
            response_type: 'code',
            state: SecureRandom.hex(12),
            scope: 'com.intuit.quickbooks.accounting'
          )
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

          response = request(:post, url, headers: OAUTH_HEADERS.dup, body: payload.to_json)
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

        def set_credentials_from_oauth_code(code:, redirect_uri:)
          oauth_token = oauth_client.auth_code.get_token(
            code,
            redirect_uri: redirect_uri
          )

          set_credentials_from_oauth_token(token: oauth_token)

          oauth_token
        end

        def url_for(resource:)
          base_url = test ? 'https://app.sandbox.qbo.intuit.com/app' : 'https://qbo.intuit.com/app'
          resource_path = case resource
                          when LedgerSync::Account
                            "/register?accountId=#{resource.ledger_id}"
                          when LedgerSync::Bill
                            "/bill?txnId=#{resource.ledger_id}"
                          when LedgerSync::Customer
                            "/customerdetail?nameId=#{resource.ledger_id}"
                          when LedgerSync::Deposit
                            "/deposit?txnId=#{resource.ledger_id}"
                          when LedgerSync::Expense
                            "/expense?txnId=#{resource.ledger_id}"
                          when LedgerSync::JournalEntry
                            "/journal?txnId=#{resource.ledger_id}"
                          when LedgerSync::Payment
                            "/recvpayment?txnId=#{resource.ledger_id}"
                          when LedgerSync::Transfer
                            "/transfer?txnId=#{resource.ledger_id}"
                          when LedgerSync::Vendor
                            "/vendordetail?nameId=#{resource.ledger_id}"
                          end

          base_url + resource_path
        end

        def self.ledger_attributes_to_save
          %i[access_token expires_at refresh_token refresh_token_expires_at]
        end

        private

        def oauth_base_uri
          @oauth_base_uri ||= "#{root_uri}/v3/company/#{realm_id}"
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

        def set_credentials_from_oauth_token(token:)
          @previous_access_tokens << access_token if access_token.present?
          @access_token = token.token

          @expires_at = Time&.at(token.expires_at.to_i)&.to_datetime
          @refresh_token_expires_at = Time&.at(Time.now.to_i + token.params['x_refresh_token_expires_in'])&.to_datetime unless token.params['x_refresh_token_expires_in'].nil?

          @previous_refresh_tokens << refresh_token if refresh_token.present?
          @refresh_token = token.refresh_token

          oauth(force: true) # Ensure we update the memoized @oauth
        end
      end
    end
  end
end
