# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuiteREST
      module LedgerSerializerType
        class ReferenceType < Adaptors::LedgerSerializerType::ValueType
          def convert_from_ledger(value:)
            nil
          end

          def convert_from_local(value:)
            return if value.nil?
            raise "Resource expected.  Given: #{value.class.name}" unless value.is_a?(LedgerSync::Resource)

            {
              'id' => value.ledger_id
            }
          end
        end
      end
    end
  end
end
