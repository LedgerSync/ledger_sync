# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
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
        rescue OAuth2::Error => e
          error = parse_error(error: e)

          if error.is_a?(Error::LedgerError::AuthenticationError)
            begin
              client.refresh!
              @response = generate_response(
                body: body,
                headers: headers,
                method: method,
                url: url
              )
              return @response
            rescue OAuth2::Error => e
              raise parse_error(error: e)
            end
          end

          raise error
        end

        def refresh!
          oauth.refresh!
        rescue OAuth2::Error => e
          raise parse_error(error: e)
        end

        private

        def generate_response(body:, headers:, method:, url:)
          oauth_response = oauth.send(
            method,
            url,
            body: (body.to_json unless body.nil?),
            headers: headers
          )
          ret = Response.new_from_oauth_response(
            oauth_response: oauth_response,
            request: self
          )
          @performed = true
          ret
        end

        def parse_error(error:)
          parsed_client_error(error: error) ||
            parsed_operation_error(error: error) ||
            error
        end

        def parsed_client_error(error:)
          Util::LedgerErrorParser.new(
            error: error,
            client: self
          ).parse
        end

        def parsed_operation_error(error:)
          return nil unless error.is_a?(OAuth2::Error)

          Util::OperationErrorParser.new(
            error: error
          ).parse
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
