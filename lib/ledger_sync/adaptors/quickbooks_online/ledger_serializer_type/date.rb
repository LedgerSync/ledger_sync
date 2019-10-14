# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class Date < Adaptors::LedgerSerializerType::Mapping
          private

          def convert_from_ledger
            return value if value.nil?

            value.to_date
          end

          def convert_from_local
            return value if value.nil?

            value.to_s
          end
        end
      end
    end
  end
end
