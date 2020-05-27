# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CustomerDeposit
        class Serializer < NetSuite::Serializer
          attribute :account,
                    type: Type::SerializerReferenceType.new

          attribute :customer,
                    type: Type::SerializerReferenceType.new

          attribute :entityId,
                    resource_attribute: :external_id

          attribute :externalId,
                    resource_attribute: :external_id

          attribute :payment
          attribute :undepFunds
        end
      end
    end
  end
end
