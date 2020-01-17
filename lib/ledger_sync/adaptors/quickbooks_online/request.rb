# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class Request < Adaptors::Request
        attr_reader :adaptor

        def initialize(*args, adaptor:, **keywords)
          @adaptor = adaptor
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

          if error.is_a?(Error::AdaptorError::AuthenticationError)
            begin
              adaptor.refresh!
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
            body: body,
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
          parsed_adaptor_error(error: error) ||
            parsed_operation_error(error: error) ||
            error
        end

        def parsed_adaptor_error(error:)
          Util::AdaptorErrorParser.new(
            error: error,
            adaptor: self
          ).parse
        end

        def parsed_operation_error(error:)
          return nil unless error.is_a?(OAuth2::Error)

          Util::OperationErrorParser.new(
            error: error
          ).parse
        end

        def oauth
          adaptor.oauth
        end

        def oauth_client
          adaptor.oauth_client
        end
      end
    end
  end
end
