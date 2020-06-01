# frozen_string_literal: true

require_relative '../reference/serializer'

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

          references_one :subsidiary,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end
