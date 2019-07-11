# frozen_string_literal: true

module LedgerSync
  module Util
    class Performer
      attr_reader :operations

      def initialize(operations:)
        @operations = operations
      end

      def perform
        @perform ||= validate_all
                     .and_then { perform_all }
                     .and_then { Result.Success(self) }
      end

      private

      def perform_all
        operations.inject(Result.Success) { |res, op| res.and_then { op.perform } }
      end

      def validate_all
        operations.inject(Result.Success) { |res, op| res.and_then { op.validate } }
      end
    end
  end
end
