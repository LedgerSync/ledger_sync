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

        def get(**keywords)
          request(keywords.merge(method: :get))
        end

        def post(**keywords)
          response = request(
            keywords.merge(
              headers: (keywords[:headers] || {}).merge(POST_HEADERS),
              method: :post
            )
          )
          JSON.parse(response.body)
        end

        def self.ledger_attributes_to_save
          %i[]
        end

        private

        def new_token(method:, url:)
          Token.new(
            account_id: account_id_for_oauth,
            consumer_key: consumer_key,
            consumer_secret: consumer_secret,
            method: method,
            token_id: token_id,
            token_secret: token_secret,
            url: url
          )
        end

        def request(body: nil, headers: {}, method:, path: nil)
          request_url = url_from_path(path: path)
          token = new_token(
            method: method,
            url: request_url
          )

          request = Request.new(
            body: body,
            headers: headers.merge(token.headers),
            method: method,
            url: request_url
          )

          request.perform
        end

        def url_from_path(path:)
          request_url = api_base_url
          request_url += '/' unless path.start_with?('/')
          request_url + path
        end
      end
    end
  end
end
