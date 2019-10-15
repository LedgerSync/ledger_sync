# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class Date < Adaptors::LedgerSerializerType::Mapping
          def convert_from_ledger(value:)
            return value if value.nil?

            value.to_date
          end

          def convert_from_local(value:)
            return value if value.nil?

            value.to_s
          end
        end
      end
    end
  end
end
