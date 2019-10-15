# frozen_string_literal: true

require_relative 'value_mixin'

# Mixin for lib-specific Type functions
module LedgerSync
  module Type
    class Value < ActiveModel::Type::Value
      include ValueMixin

      def error_message(attribute:, resource:, value:)
        "Attribute #{attribute.name} for #{resource.class.name} should be a class supported by #{self.class.name}.  Given: #{value.class}"
      end
    end
  end
end
