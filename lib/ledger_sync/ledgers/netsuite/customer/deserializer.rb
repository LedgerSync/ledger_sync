# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Customer
        class Deserializer < NetSuite::Deserializer
          id

          attribute :companyName
          attribute :firstName
          attribute :lastName
          attribute :email
          attribute :phone

          attribute :subsidiary,
                    type: Type::DeserializerSubsidiaryType.new(subsidiary_class: Subsidiary)
        end
      end
    end
  end
end
