# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Customer
        class SearcherLedgerDeserializer < NetSuite::LedgerSerializer
          attribute ledger_attribute: :id,
                    resource_attribute: :ledger_id

          attribute ledger_attribute: :email,
                    resource_attribute: :email

          attribute ledger_attribute: :companyname,
                    resource_attribute: :name

          attribute ledger_attribute: :phone,
                    resource_attribute: :phone_number
        end
      end
    end
  end
end
