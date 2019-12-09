# frozen_string_literal: true

require 'oauth2'

module LedgerSync
  module Adaptors
    module NetSuiteREST
      class Adaptor < LedgerSync::Adaptors::Adaptor
        POST_HEADERS = {
          'Accept' => 'application/schema+json'
        }.freeze

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

        def api_base_url
          @api_base_url ||= "https://#{account_id_for_url}.suitetalk.api.netsuite.com/rest/platform/v1"
        end

        def authorization_url(redirect_uri:)
          oauth_client.auth_code.authorize_url(
            redirect_uri: redirect_uri,
            response_type: 'code',
            state: SecureRandom.hex(12),
            scope: 'com.intuit.quickbooks.accounting'
          )
        end

        def get(**keywords)
          response = request(keywords.merge(http_method: :get))
          JSON.parse(response.body)
        end

        def post(**keywords)
          response = request(
            keywords.merge(
              headers: (keywords[:headers] || {}).merge(POST_HEADERS),
              http_method: :post
            )
          )
          JSON.parse(response.body)
        end

        def self.ledger_attributes_to_save
          %i[]
        end

        private

        def request(body: nil, headers: {}, http_method:, path: nil)
          request_url = api_base_url
          request_url += '/' unless path.start_with?('/')
          request_url += path

          token = Token.new(
            account_id: account_id_for_oauth,
            consumer_key: consumer_key,
            consumer_secret: consumer_secret,
            http_method: http_method,
            token_id: token_id,
            token_secret: token_secret,
            url: request_url
          )

          Faraday.send(http_method, request_url) do |req|
            req.headers.merge!(token.headers)
            req.headers.merge!(headers)
            req.body = body.to_json unless body.nil?
          end
        end
      end
    end
  end
end
