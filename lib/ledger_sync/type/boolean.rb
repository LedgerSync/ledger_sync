# frozen_string_literal: true

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
