# frozen_string_literal: true

require_relative 'error_matcher'

module LedgerSync
  module Util
    class ErrorParser
      attr_reader :error

      def initialize(args = {})
        @error = args.fetch(:error)
        @matchers = args.fetch(:matchers, nil)
      end

      def additional_error_args
        {}
      end

      def error_class
        raise NotImplementedError
      end

      def parse
        matchers.map do |parser|
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

      def matchers
        @matchers ||= self.class::MATCHERS
      end
    end
  end
end
