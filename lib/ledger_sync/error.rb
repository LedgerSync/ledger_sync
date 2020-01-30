# frozen_string_literal: true

module LedgerSync
  class Error < StandardError
    module HelpersMixin
      module ClassMethods
        def raise_if_unexpected_class(expected:, given:)
          expected = [expected] unless expected.is_a?(Array)
          expected = expected.map { |e| (e.is_a?(Class) ? e : e.class) }
          given = given.class unless given.is_a?(Class)

          return if expected.any? { |c| given <= c }

          raise UnexpectedClassError.new(
            expected: expected,
            given: given
          )
        end
      end

      def self.included(base)
        base.extend ClassMethods
      end
    end

    attr_reader :message

    def initialize(message:)
      @message = message
      super(message)
    end

    class UnexpectedClassError < self
      def initialize(expected:, given:)
        expected = [expected] unless expected.is_a?(Array)

        super(
          message: "Unexpected class.  Given #{given.name}.  Expected: #{expected.map(&:name).join(', ')}"
        )
      end
    end
  end
end
