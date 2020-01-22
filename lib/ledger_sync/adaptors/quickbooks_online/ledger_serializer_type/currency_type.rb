# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class CurrencyType < Adaptors::LedgerSerializerType::ValueType
          def convert_from_ledger(value:)
            return value if value.nil?

            LedgerSync::Currency.new(
              symbol: value
            )
          end

          def convert_from_local(value:)
            return value if value.nil?

            value.symbol
          end
        end
      end
    end
  end
end
