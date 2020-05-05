# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module LedgerClass
        class SearcherLedgerDeserializer < NetSuite::LedgerSerializer
          attribute ledger_attribute: :id,
                    resource_attribute: :ledger_id

          attribute ledger_attribute: :name,
                    resource_attribute: :name

          attribute ledger_attribute: :isinactive,
                    resource_attribute: :active,
                    type: LedgerSerializerType::ActiveType
        end
      end
    end
  end
end
