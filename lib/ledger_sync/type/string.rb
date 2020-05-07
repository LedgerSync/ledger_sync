# frozen_string_literal: true

require_relative 'value_mixin'

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
