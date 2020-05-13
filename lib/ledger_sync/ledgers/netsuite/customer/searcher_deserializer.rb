# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Customer
        class SearcherDeserializer < NetSuite::Deserializer
          id

          attribute :email

          attribute :name,
                    hash_attribute: :companyname

          attribute :phone_number,
                    hash_attribute: :phone
        end
      end
    end
  end
end
