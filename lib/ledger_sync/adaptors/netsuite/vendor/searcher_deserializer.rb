# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Vendor
        class SearcherDeserializer < NetSuite::Deserializer
          id

          attribute :email

          attribute :company_name,
                    hash_attribute: :companyname

          attribute :phone_number,
                    hash_attribute: :phone
        end
      end
    end
  end
end
