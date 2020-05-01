# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class DepartmentReferenceType < Adaptors::LedgerSerializerType::ValueType
          def convert_from_ledger(value:)
            return if value.nil?
            return if value['value'].nil?

            LedgerSync::Department.new(ledger_id: value['value'])
          end

          def convert_from_local(value:)
            return if value.nil?

            {
              'value' => value.ledger_id
            }
          end
        end
      end
    end
  end
end
