# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Account
        class SearcherLedgerDeserializer < NetSuite::LedgerSerializer
          attribute ledger_attribute: :id,
                    resource_attribute: :ledger_id

          attribute ledger_attribute: :accountsearchdisplayname,
                    resource_attribute: :name

          attribute ledger_attribute: :acctnumber,
                    resource_attribute: :number

          attribute ledger_attribute: :accttype,
                    resource_attribute: :account_type

          attribute ledger_attribute: :description,
                    resource_attribute: :description

          attribute ledger_attribute: :isinactive,
                    resource_attribute: :active,
                    type: LedgerSerializerType::ActiveType
        end
      end
    end
  end
end
