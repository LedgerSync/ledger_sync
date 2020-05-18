# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Serialization
        module Type
          class IntegerToAmountFloatType < LedgerSync::Type::Value
            def cast_value(args = {})
              value = args.fetch(:value)

              return if value.nil?

              value / 100.0
            end
          end
        end
      end
    end
  end
end
