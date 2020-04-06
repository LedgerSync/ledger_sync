# frozen_string_literal: true

require_relative '../invoice_sales_line_item/ledger_serializer'

module LedgerSync
  module Adaptors
    module NetSuite
      module Invoice
        class LedgerSerializer < NetSuite::LedgerSerializer
          id

          api_resource_type :invoice

          attribute ledger_attribute: :entity,
                    resource_attribute: 'customer.ledger_id'
          attribute ledger_attribute: :location,
                    resource_attribute: 'location.ledger_id'

          references_many ledger_attribute: 'items',
                          resource_attribute: :line_items,
                          serializer: InvoiceSalesLineItem::LedgerSerializer
        end
      end
    end
  end
end
