# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      module Customer
        class Deserializer < NetSuite::Deserializer
          id

          attribute :name,
                    hash_attribute: :companyName

          attribute :email

          attribute :phone_number,
                    hash_attribute: :phone

          attribute :subsidiary,
                    type: Type::Deserializer::Subsidiary.new
        end
      end
    end
  end
end
