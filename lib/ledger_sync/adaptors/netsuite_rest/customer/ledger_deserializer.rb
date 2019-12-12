# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuiteREST
      module Customer
        class LedgerDeserializer < NetSuiteREST::LedgerSerializer
          attribute ledger_attribute: :id,
                    resource_attribute: :ledger_id

          attribute ledger_attribute: :companyName,
                    resource_attribute: :name

          attribute ledger_attribute: :email,
                    resource_attribute: :email

          attribute ledger_attribute: :phone,
                    resource_attribute: :phone_number

          attribute ledger_attribute: 'subsidiary.id',
                    resource_attribute: :subsidiary,
                    type: LedgerSerializerType::ReferenceType
        end
      end
    end
  end
end
