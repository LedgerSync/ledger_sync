# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Vendor
        class Deserializer < NetSuite::Deserializer
          id

          attribute :company_name,
                    ledger_attribute: :companyName

          attribute :email

          attribute :phone_number,
                    ledger_attribute: :phone

          attribute :first_name,
                    ledger_attribute: :firstName

          attribute :last_name,
                    ledger_attribute: :lastName

          attribute :subsidiary,
                    type: Type::Deserializer::Subsidiary.new
        end
      end
    end
  end
end
