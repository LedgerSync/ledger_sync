# frozen_string_literal: true

module LedgerSync
  module Type
    class Hash < Value # :nodoc:
      include ValueMixin

      def cast?
        true
      end

      def changed_in_place?(raw_old_value, new_value)
        raw_old_value != new_value if new_value.is_a?(::Hash)
      end

      def type
        :id
      end

      def valid_classes
        [::Hash]
      end

      private

      def cast_value(value)
        case value
        when ::Hash then value.clone
        else { value: valuev}
        end
      end
    end
  end
end
