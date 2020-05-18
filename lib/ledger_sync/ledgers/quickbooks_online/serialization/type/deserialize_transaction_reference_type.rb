# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Serialization
        module Type
          class DeserializeTransactionReferenceType < LedgerSync::Type::Value
            def cast_value(value:)
              return if value.nil?

              raise "Unknown value type.  Array expected.  Given: #{value.class.name}" unless value.is_a?(Array)
              return if value.empty?

              value.map do |item|
                resource_class = Client.resource_from_ledger_type(type: item['TxnType'])

                raise "Unknown QuickBooks Online resource type: #{item['TxnType']}" if resource_class.blank?

                resource_class.new(
                  ledger_id: item['TxnId']
                )
              end
            end
          end
        end
      end
    end
  end
end
