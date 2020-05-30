# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Customer
        class Serializer < NetSuite::Serializer
          attribute :companyName

          attribute :externalId,
                    resource_attribute: :external_id

          attribute :email

          attribute :phone

          attribute :firstName

          attribute :lastName

          attribute :subsidiary,
                    type: Type::SerializerReferenceType.new
        end
      end
    end
  end
end
