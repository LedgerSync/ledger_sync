# frozen_string_literal: true

require_relative 'error_parser'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Util
        class AdaptorErrorParser < ErrorParser
          class ThrottleMatcher < ErrorMatcher
            def error_klass
              Error::AdaptorError::ThrottleError
            end

            def output_message
              "Request trhottled with: #{error_message}"
            end

            def match?
              message.include?('source=throttling policy') ||
                message.include?('errorcode=003001')
            end
          end

          class AuthenticationMatcher < ErrorMatcher
            def error_klass
              Error::AdaptorError::AuthenticationError
            end

            def output_message
              "Authentication Failed with: #{error_message}"
            end

            def match?
              code == 3200 ||
              message.include?('authenticationfailed') ||
                message.include?('errorcode=003200')
            end
          end

          class AuthorizationMatcher < ErrorMatcher
            def error_klass
              Error::AdaptorError::AuthorizationError
            end

            def output_message
              "Authorization Failed with: #{error_message}"
            end

            def match?
              code == 3100 ||
              message.include?('authorizationfailed') ||
                message.include?('errorcode=003100')
            end
          end

          class ClientMatcher < ErrorMatcher
            def error_klass
              Error::AdaptorError::ConfigurationError
            end

            def output_message
              "Missing Configuration: #{error_message}"
            end

            def match?
              message.include?('invalid_client') ||
                message.include?('invalid_grant')
            end
          end

          PARSERS = [
            AuthenticationMatcher,
            AuthorizationMatcher,
            ClientMatcher,
            ThrottleMatcher
          ].freeze

          attr_reader :adaptor

          def initialize(adaptor:, error:)
            @adaptor = adaptor
            super(error: error)
          end

          def parse
            PARSERS.map do |parser|
              matcher = parser.new(error: error)
              next unless matcher.match?

              return matcher.error_klass.new(
                adaptor: adaptor,
                message: matcher.output_message,
                response: error
              )
            end
            nil
          end
        end
      end
    end
  end
end
