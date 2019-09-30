# frozen_string_literal: true

module LedgerSync
  module Type
    class Float < ActiveModel::Type::Float # :nodoc:
      include ValueMixin

      def type
        :float
      end

      def valid_classes
        [::Float]
      end
    end
  end
end
