# frozen_string_literal: true

module LedgerSync
  module Type
    class Date < ActiveModel::Type::Date # :nodoc:
      include ValueMixin

      def type
        :date
      end

      def valid_classes
        [::Date]
      end
    end
  end
end
