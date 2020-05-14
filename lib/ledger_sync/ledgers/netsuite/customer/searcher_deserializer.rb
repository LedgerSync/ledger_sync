# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Customer
        class SearcherDeserializer < NetSuite::Deserializer
          id

          attribute :email
          attribute :companyName,
                    hash_attribute: :companyname
          attribute :phone
        end
      end
    end
  end
end
