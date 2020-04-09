# frozen_string_literal: true

require_relative '../item/ledger_serializer'

module LedgerSync
  module Adaptors
    module NetSuite
      module InvoiceSalesLineItem
        class LedgerSerializer < NetSuite::LedgerSerializer
          references_one ledger_attribute: :item,
                        resource_attribute: :item,
                        serializer: Item::LedgerSerializer

          # attribute ledger_attribute: :amount,
          #           resource_attribute: :amount

          # attribute ledger_attribute: :description,
          #           resource_attribute: :description
        end
      end
    end
  end
end
