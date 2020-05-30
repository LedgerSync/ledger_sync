# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Vendor
        class Serializer < NetSuite::Serializer
          attribute :companyName,
                    resource_attribute: :company_name

          attribute :externalId,
                    resource_attribute: :external_id

          attribute :email

          attribute :firstName,
                    resource_attribute: :first_name

          attribute :lastName,
                    resource_attribute: :last_name

          attribute :subsidiary,
                    type: Type::SerializerReferenceType.new
        end
      end
    end
  end
end
