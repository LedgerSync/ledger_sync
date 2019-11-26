# frozen_string_literal: true

require 'oauth2'

module LedgerSync
  module Adaptors
    module NetSuiteREST
      class Adaptor < LedgerSync::Adaptors::Adaptor
        attr_reader :account_id,
                    :consumer_key,
                    :consumer_secret,
                    :token_id,
                    :token_secret

        def initialize(
          account_id:,
          consumer_key:,
          consumer_secret:,
          token_id:,
          token_secret:
        )
          @account_id = account_id
          @consumer_key = consumer_key
          @consumer_secret = consumer_secret
          @token_id = token_id
          @token_secret = token_secret
        end

        def account_id_for_oauth
          account_id.split('-sb').join('_SB')
        end

        def account_id_for_url
          account_id.split('_SB').join('-sb')
        end

        def authorization_url(redirect_uri:)
          oauth_client.auth_code.authorize_url(
            redirect_uri: redirect_uri,
            response_type: 'code',
            state: SecureRandom.hex(12),
            scope: 'com.intuit.quickbooks.accounting'
          )
        end

        def get(url:)
          response = request(method: :get, url: url)
          JSON.parse(response.body)
        end

        def self.ledger_attributes_to_save
          %i[]
        end

        private

        # ref: https://docs.oracle.com/cloud/latest/netsuitecs_gs/NSATH/NSATH.pdf
        def request(method:, url:, body: {})
          nonce = SecureRandom.alphanumeric
          timestamp = Time.zone.now.to_i.to_s
          signature_data = [
            CGI.escape(account_id_for_oauth),
            CGI.escape(consumer_key),
            CGI.escape(token_id),
            CGI.escape(nonce),
            CGI.escape(timestamp)
          ].join('&')

          signature_key = [
            CGI.escape(consumer_secret),
            CGI.escape(token_secret)
          ].join('&')

          signature = OpenSSL::HMAC.hexdigest('SHA256', signature_key, signature_data)

          Faraday.send(method, url) do |req|
            req.headers['Authorization'] = "OAuth realm=\"#{account_id_for_oauth}\",oauth_consumer_key=\"#{consumer_key}\",oauth_token=\"#{token_id}\",oauth_signature_method=\"HMAC-SHA1\",oauth_signature=\"#{signature}\",oauth_timestamp=\"#{timestamp}\",oauth_nonce=\"#{nonce}\",oauth_version=\"1.0\"",
            req.headers['Accept'] = 'application/swagger+json',
            req.body = body.to_json
          end
        end
      end
    end
  end
end
