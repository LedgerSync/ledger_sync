# frozen_string_literal: true

module LedgerSync
  module Type
    class CastableSymbol < Value # :nodoc:
      include ValueMixin

      def cast?
        true
      end

      def changed_in_place?(raw_old_value, new_value)
        raw_old_value != new_value if new_value.is_a?(::Symbol)
      end

      def type
        :id
      end

      def valid_classes
        [::String, ::Symbol]
      end

      private

      def cast_value(value)
        case value
        when ::Symbol then value
        else value.to_sym
        end
      end
    end
  end
end
