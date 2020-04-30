# frozen_string_literal: true

# Mixin for lib-specific Type functions
module LedgerSync
  module Type
    module ValueMixin
      def self.included(base)
        base.include SimplySerializable::Mixin
      end

      def cast?
        false
      end

      def error_message(attribute:, resource_class:, value:)
        "Attribute #{attribute.name} for #{resource_class.name} should be a class supported by #{self.class.name}.  Given: #{value.class}"
      end

      def valid_classes
        raise NotImplementedError
      end

      def valid_without_casting?(value:)
        return true if value.nil?
        return true if valid_classes.select { |e| value.is_a?(e) }.any?

        false
      end
    end
  end
end
