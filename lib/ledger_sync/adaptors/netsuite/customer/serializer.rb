# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Customer
        class Serializer < NetSuite::Serializer
          attribute :companyName,
                    resource_attribute: :name

          attribute :entityId,
                    resource_attribute: :external_id

          attribute :externalId,
                    resource_attribute: :external_id

          attribute :email

          attribute :phone,
                    resource_attribute: :phone_number

          # attribute :firstName,
          #           resource_attribute: :first_name

          # attribute :lastName,
          #           resource_attribute: :last_name

          attribute :subsidiary,
                    type: Type::Serializer::Reference.new
        end
      end
    end
  end
end
