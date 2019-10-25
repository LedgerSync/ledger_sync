# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class AmountType < Adaptors::LedgerSerializerType::ValueType
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
