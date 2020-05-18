# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class InvoiceSalesLineItem
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute 'DetailType' do
            'SalesItemLineDetail'
          end

          attribute 'SalesItemLineDetail.ItemRef.value',
                    resource_attribute: 'item.ledger_id'

          attribute 'SalesItemLineDetail.ClassRef.value',
                    resource_attribute: 'ledger_class.ledger_id'

          amount 'Amount',
                 resource_attribute: :amount

          attribute 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end
