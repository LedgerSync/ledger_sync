# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Customer
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
