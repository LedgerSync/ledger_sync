# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module LedgerSerializerType
        class ReferenceType < Adaptors::LedgerSerializerType::ValueType
          def convert_from_ledger(args = {})
            value = args.fetch(:value)
            resource_class = args.fetch(:resource_class)

            resource_class.new(
              ledger_id: value.fetch('id')
            )
          end

          def convert_from_local(value:)
            return if value.nil?
            raise "Resource expected.  Given: #{value.class.name}" unless value.is_a?(LedgerSync::Resource)

            value.ledger_id
          end
        end
      end
    end
  end
end
