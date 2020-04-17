# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module LedgerSerializerType
        module Item
          class TypeType < Adaptors::LedgerSerializerType::MappingType
            MAPPING = Hash[
              %w[
                inventoryItem
                nonInventoryItem
                serviceItem
                otherChargeItem
                assemblyItem
                kitItem
                nsResource
                discountItem
                markupItem
                subtotalItem
                descriptionItem
                paymentItem
                salesTaxItem
                taxGroup
                shipItem
                downloadItem
                giftCertificateItem
                subscriptionPlan
              ].map { |v| [v.snakecase.to_sym, v] }
            ].freeze

            def self.mapping
              @mapping ||= MAPPING
            end
          end
        end
      end
    end
  end
end