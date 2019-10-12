# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class Amount < Adaptors::LedgerSerializerType::Mapping
          private

          def convert_from_ledger
            (value * 100).to_i
          end

          def convert_from_local
            value / 100.0
          end
        end
      end
    end
  end
end
