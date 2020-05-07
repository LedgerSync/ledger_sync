# frozen_string_literal: true

require_relative 'value_mixin'

module LedgerSync
  module Type
    class Integer < ActiveModel::Type::Integer # :nodoc:
      include ValueMixin

      def type
        :integer
      end

      def valid_classes
        [::Integer]
      end
    end
  end
end
