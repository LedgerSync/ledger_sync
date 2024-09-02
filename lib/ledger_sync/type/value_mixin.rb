# frozen_string_literal: true

# Mixin for lib-specific Type functions
module LedgerSync
  module Type
    module ValueMixin
      def self.included(base)
        base.include SimplySerializable::Mixin
      end

      def assert_valid(args = {})
        return if valid?(args)

        value = args.fetch(:value)

        raise Error::TypeError::ValueClassError.new(
          expected: valid_classes,
          given: value.class
        )
      end

      # Do not override this method.  Override private method cast_value
      def cast(args = {})
        assert_valid(args)

        cast_value(args)
      end

      def valid?(args = {})
        valid_class?(args)
      end

      private

      # Override this method to handle different types of casting.
      def cast_value(args = {})
        value = args.fetch(:value)

        super(value)
      end

      def valid_class?(args = {})
        value = args.fetch(:value)

        return true if value.nil?
        return true if valid_classes.select { |e| value.is_a?(e) }.any?

        false
      end

      def valid_classes
        [
          Object
        ]
      end

      # def cast?
      #   false
      # end
    end
  end
end
