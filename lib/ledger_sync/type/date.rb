# frozen_string_literal: true

require_relative 'value_mixin'

module LedgerSync
  module Type
    class Date < ActiveModel::Type::Date # :nodoc:
      include ValueMixin

      def type
        :date
      end

      def valid?(args = {})
        return false unless valid_class?(args)

        value = args.fetch(:value)
        return true unless value.is_a?(::String)
        return false unless value =~ /\A[0-9]{4}-[0-9]{2}-[0-9]{2}\z/

        true
      end

      def valid_classes
        [::Date, ::String]
      end
    end
  end
end
