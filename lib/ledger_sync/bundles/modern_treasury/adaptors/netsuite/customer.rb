# frozen_string_literal: true

module LedgerSync
  module Bundles
    module ModernTreasury
      module Adaptors
        module NetSuite
          class Customer < ResourceAdaptor
            attribute :email
            attribute :companyName, resource_attribute: :name
            attribute :firstName, resource_attribute: :first_name
            attribute :lastName, resource_attribute: :last_name
            attribute :phone, resource_attribute: :phone_number
          end
        end
      end
    end
  end
end
