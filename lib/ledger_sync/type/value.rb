# frozen_string_literal: true

require_relative 'value_mixin'

# Mixin for lib-specific Type functions
module LedgerSync
  module Type
    class Value < ActiveModel::Type::Value
      include ValueMixin
    end
  end
end
