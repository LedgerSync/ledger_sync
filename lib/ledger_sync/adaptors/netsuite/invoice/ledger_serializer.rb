# frozen_string_literal: true

require_relative '../invoice_sales_line_item/ledger_serializer'

module LedgerSync
  module Adaptors
    module NetSuite
      module Invoice
        class LedgerSerializer < NetSuite::LedgerSerializer
          module SharedSerializerAttributes
            def self.extended(mod)
              mod.api_resource_type :invoice

              mod.attribute ledger_attribute: :entity,
                            resource_attribute: 'customer.ledger_id'
              mod.attribute ledger_attribute: :location,
                            resource_attribute: 'location.ledger_id'

              mod.references_many ledger_attribute: 'item.items',
                                  resource_attribute: :line_items,
                                  serializer: InvoiceSalesLineItem::LedgerSerializer
            end
          end

          extend SharedSerializerAttributes

          def self.inherited(base)
            base.extend(SharedSerializerAttributes)
          end
        end
      end
    end
  end
end
