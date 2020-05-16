# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerSerializerType
        class AmountType < Ledgers::LedgerSerializerType::ValueType
          def convert_from_ledger(value:)
            return if value.nil?

            (value * 100).to_i
          end

          def convert_from_local(value:)
            return if value.nil?

            value / 100.0
          end
        end
      end
    end
  end
end
