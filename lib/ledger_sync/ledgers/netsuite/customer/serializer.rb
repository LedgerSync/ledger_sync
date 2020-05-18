# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Customer
        class Serializer < NetSuite::Serializer
          attribute :companyName

          attribute :entityId,
                    resource_attribute: :external_id

          attribute :externalId,
                    resource_attribute: :external_id

          attribute :email

          attribute :phone

          attribute :firstName

          attribute :lastName

          attribute :subsidiary,
                    type: Serialization::Type::Reference.new
        end
      end
    end
  end
end
