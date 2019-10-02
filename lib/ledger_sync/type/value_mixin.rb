# frozen_string_literal: true

# Mixin for lib-specific Type functions
module LedgerSync
  module Type
    module ValueMixin
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
