# frozen_string_literal: true

module LedgerSync
  module Type
    class String < ActiveModel::Type::String # :nodoc:
      include ValueMixin

      def type
        :string
      end

      def valid_classes
        [::String]
      end
    end
  end
end
