# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Xero
      class Request < Ledgers::Request
        attr_reader :client

        def initialize(*args, client:, **keywords)
          @client = client
          super(*args, **keywords)
        end

        def perform
          raise 'Request already performed' if performed?

          @response = generate_response(
            body: body,
            headers: headers,
            method: method,
            url: url
          )
        ensure
          @performed = true
        end

        def refresh!
          oauth.refresh!
        rescue OAuth2::Error => e
          raise e #parse_error(error: e)
        end

        private

        def generate_response(body:, headers:, method:, url:)
          oauth_response = oauth.send(
            method,
            url,
            body: (body.to_json unless body.nil?),
            headers: headers
          )

          Response.new_from_oauth_response(
            oauth_response: oauth_response,
            request: self
          )
        end

        def oauth
          client.oauth
        end

        def oauth_client
          client.oauth_client
        end
      end
    end
  end
end
