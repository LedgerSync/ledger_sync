# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Type
        class DeserializerEntityType < LedgerSync::Type::Value
          private

          def cast_value(args = {})
            value = args.fetch(:value)

            unless value.nil?
              Client.resource_from_ledger_type(
                type: value['type']
              ).new(
                ledger_id: value['value']
              )
            end
          end

          def valid_classes
            [
              Hash
            ]
          end
        end
      end
    end
  end
end
