# frozen_string_literal: true

require_relative 'string'

module LedgerSync
  module Type
    class StringFromSet < String # :nodoc:
      attr_reader :values

      def initialize(args = {})
        @values = args.fetch(:values)

        super(args.except(:values))
      end

      def assert_valid(args = {})
        return if valid_value?(args)

        raise Error::TypeError::StringFromSetError.new(
          expected: @values,
          given: args.fetch(:value)
        )
      end

      def valid?(args = {})
        super && valid_value?(args)
      end

      def type
        :StringFromSet
      end

      private

      def valid_value?(args = {})
        value = args.fetch(:value).try(:to_s)
        return true if value.blank?

        @values.include?(value)
      end
    end
  end
end
