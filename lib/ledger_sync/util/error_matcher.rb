# frozen_string_literal: true

module LedgerSync
  module Util
    class ErrorMatcher
      attr_reader :error,
                  :message

      def initialize(args = {})
        @error = args.fetch(:error)
        @message = error.message.to_s
      end

      def body
        @body ||= error.response.body
      rescue NoMethodError
        nil
      end

      def error_class
        raise NotImplementedError
      end

      def match?
        raise NotImplementedError
      end

      def output_message
        raise NotImplementedError
      end
    end
  end
end
