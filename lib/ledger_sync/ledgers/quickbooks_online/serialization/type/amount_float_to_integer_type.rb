# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Serialization
        module Type
          class AmountFloatToIntegerType < LedgerSync::Type::Value
            def cast_value(args = {})
              value = args.fetch(:value)

              return if value.nil?

              (value * 100).to_i
            end
          end
        end
      end
    end
  end
end
