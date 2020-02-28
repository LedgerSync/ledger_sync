# frozen_string_literal: true

require 'oauth2'

module LedgerSync
  module Adaptors
    module NetSuite
      class Adaptor < LedgerSync::Adaptors::Adaptor
        HEADERS = {
          # 'Accept' => 'application/schema+json'
        }.freeze

        WRITE_HEADERS = {
          'Accept' => '*/*',
          'Content-Type' => 'application/json'
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
          @api_base_url ||= "https://#{api_host}/services/rest/record/v1"
        end

        def api_host
          @api_host ||= "#{account_id_for_url}.suitetalk.api.netsuite.com"
        end

        def delete(**keywords)
          request(keywords.merge(method: :delete))
        end

        def get(**keywords)
          request(keywords.merge(method: :get))
        end

        def patch(headers: {}, **keywords)
          request(
            keywords.merge(
              headers: WRITE_HEADERS.merge(headers),
              method: :patch
            )
          )
        end

        def post(headers: {}, **keywords)
          request(
            keywords.merge(
              headers: WRITE_HEADERS.merge(headers),
              method: :post
            )
          )
        end

        def self.ledger_attributes_to_save
          %i[]
        end

        def self.new_from_env(**override)
          new(
            {
              account_id: ENV.fetch('NETSUITE_ACCOUNT_ID', nil),
              consumer_key: ENV.fetch('NETSUITE_CONSUMER_KEY', nil),
              consumer_secret: ENV.fetch('NETSUITE_CONSUMER_SECRET', nil),
              token_id: ENV.fetch('NETSUITE_TOKEN_ID', nil),
              token_secret: ENV.fetch('NETSUITE_TOKEN_SECRET', nil)
            }.merge(override)
          )
        end

        private

        def new_token(body:, method:, url:)
          Token.new(
            body: body,
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
            body: body,
            method: method,
            url: request_url
          )

          request = Request.new(
            body: body,
            headers: headers
              .merge(HEADERS)
              .merge(
                token.headers(
                  realm: account_id_for_oauth
                )
              )
              .merge(
                'Host' => api_host
              ),
            method: method,
            url: request_url
          )

          request.perform
        end

        def url_from_path(path:)
          request_url = api_base_url
          request_url += '/' unless path.to_s.start_with?('/')
          request_url + path.to_s
        end
      end
    end
  end
end
