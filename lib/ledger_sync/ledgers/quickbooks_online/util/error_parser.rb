# frozen_string_literal: true

require_relative 'error_matcher'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Util
        class ErrorParser
          attr_reader :error

          def initialize(args = {})
            @error = args.fetch(:error)
            @parsers = args.fetch(:parsers, nil)
          end

          def additional_error_args
            {}
          end

          def error_class
            raise NotImplementedError
          end

          def parse
            parsers.map do |parser|
              matcher = parser.new(error: error)
              next unless matcher.match?

              return matcher.error_class.new(
                additional_error_args.merge(
                  message: matcher.output_message,
                  response: error
                )
              )
            end

            nil
          end

          def parsers
            @parsers ||= self.class::PARSERS
          end
        end
      end
    end
  end
end
