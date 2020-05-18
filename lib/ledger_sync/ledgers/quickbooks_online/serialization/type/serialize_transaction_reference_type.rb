# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Serialization
        module Type
          class SerializeTransactionReferenceType < LedgerSync::Type::Value
            def cast_value(value:)
              return if value.nil?
              raise "List expected.  Given: #{value.class.name}" unless value.is_a?(Array)
              unless value.all?(LedgerSync::Resource)
                raise "Resources expected.  Given: #{value.map { |i| i.class.name }.join(', ')}"
              end

              value.map do |resource|
                {
                  'TxnId' => resource.ledger_id,
                  'TxnType' => Client.ledger_resource_type_for(
                    resource_class: resource.class
                  ).classify
                }
              end
            end
          end
        end
      end
    end
  end
end
