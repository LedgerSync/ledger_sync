# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Vendor
        class Deserializer < NetSuite::Deserializer
          id

          attribute :company_name,
                    hash_attribute: :companyName

          attribute :email

          attribute :phone_number,
                    hash_attribute: :phone

          attribute :first_name,
                    hash_attribute: :firstName

          attribute :last_name,
                    hash_attribute: :lastName

          attribute :subsidiary,
                    type: Type::Deserializer::Subsidiary.new(subsidiary_class: Subsidiary)
        end
      end
    end
  end
end
