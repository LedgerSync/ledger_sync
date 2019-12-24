# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Vendor
        class LedgerDeserializer < NetSuite::LedgerSerializer
          id

          attribute ledger_attribute: :companyName,
                    resource_attribute: :company_name

          attribute ledger_attribute: :email,
                    resource_attribute: :email

          attribute ledger_attribute: :phone,
                    resource_attribute: :phone_number

          attribute ledger_attribute: :firstName,
                    resource_attribute: :first_name

          attribute ledger_attribute: :lastName,
                    resource_attribute: :last_name

          attribute ledger_attribute: :subsidiary,
                    resource_attribute: :subsidiary,
                    type: LedgerSerializerType::SubsidiaryType
        end
      end
    end
  end
end
