# frozen_string_literal: true

require_relative 'value_mixin'

module LedgerSync
  module Type
    class Boolean < ActiveModel::Type::Boolean # :nodoc:
      include ValueMixin

      def type
        :boolean
      end

      def valid_classes
        [FalseClass, TrueClass]
      end
    end
  end
end
