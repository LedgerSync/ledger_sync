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

          oauth_response = oauth.send(method, url, body: body, headers: headers)

          @response = Response.new_from_oauth_response(
            oauth_response: oauth_response,
            request: self
          )

          @performed = true
          @response
        rescue OAuth2::Error => e
          error = parse_error(error: e)

          if error.is_a?(Error::AdaptorError::AuthenticationError)
            begin
              adaptor.refresh!
              @response = Response.new_from_oauth_response(
                oauth_response: oauth_response,
                request: self
              )
            rescue OAuth2::Error => e
              raise parse_error(error: e)
            end
          end

          byebug

          raise error
        end

        def refresh!
          oauth.refresh!
        rescue OAuth2::Error => e
          raise parse_error(error: e)
        end

        private

        def parse_error(error:)
          parsed_adaptor_error || \
            parsed_operation_error || \
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
          OAuth2::AccessToken.new(
            oauth_client.client,
            adaptor.access_token,
            refresh_token: adaptor.refresh_token
          )
        end

        def oauth_client
          @oauth_client ||= OAuthClient.new(
            client_id: adaptor.client_id,
            client_secret: adaptor.client_secret
          )
        end
      end
    end
  end
end