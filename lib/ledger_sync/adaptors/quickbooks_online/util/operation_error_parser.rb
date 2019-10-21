# frozen_string_literal: true

require_relative 'error_parser'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Util
        class OperationErrorParser < ErrorParser
          class DuplicateNameMatcher < ErrorMatcher
            def error_klass
              Error::OperationError::DuplicateLedgerResourceError
            end

            def output_message
              "Resource with same name already exists: #{error_message}"
            end

            def match?
              code == 6240 ||
              message.include?('the name supplied already exists')
            end
          end

          class NotFoundMatcher < ErrorMatcher
            def error_klass
              Error::OperationError::NotFoundError
            end

            def output_message
              "Unable to find in ledger with: #{error_message}"
            end

            def match?
              code == 610 ||
              message.include?('object not found')
            end
          end

          class ValidationError < ErrorMatcher
            def error_klass
              Error::OperationError::LedgerValidationError
            end

            def output_message
              "Ledger object is not valid: #{error_message}"
            end

            def match?
              code == 6080
            end
          end

          class GenericMatcher < ErrorMatcher
            def error_klass
              Error::OperationError
            end

            def output_message
              "Something went wrong: #{error_message}"
            end

            def match?
              true
            end
          end

          # ! always keep GenericMatcher as last
          PARSERS = [
            DuplicateNameMatcher,
            NotFoundMatcher,
            ValidationError,
            GenericMatcher
          ].freeze

          attr_reader :operation

          def initialize(operation:, error:)
            @operation = operation
            super(error: error)
          end

          def parse
            PARSERS.map do |parser|
              matcher = parser.new(error: error)
              next unless matcher.match?

              return matcher.error_klass.new(
                operation: operation,
                message: matcher.output_message,
                response: error
              )
            end
          end
        end
      end
    end
  end
end
