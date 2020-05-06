# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Vendor
        class SearcherDeserializer < NetSuite::Deserializer
          attribute :email

          attribute :company_name,
                    ledger_attribute: :companyname

          attribute :phone_number,
                    ledger_attribute: :phone
        end
      end
    end
  end
end
