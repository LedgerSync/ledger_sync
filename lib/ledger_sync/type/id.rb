# frozen_string_literal: true

require_relative 'value'

module LedgerSync
  module Type
    class ID < Value # :nodoc:
      include ValueMixin

      def cast?
        true
      end

      def changed_in_place?(raw_old_value, new_value)
        raw_old_value != new_value if new_value.is_a?(::String)
      end

      def type
        :id
      end

      def valid_classes
        [::String, ::Symbol, ::Integer, ::NilClass]
      end

      private

      def cast_value(args = {})
        value = args.fetch(:value)

        return if value.nil?

        case value
        when ::String then ::String.new(value)
        else value.to_s
        end
      end
    end
  end
end
