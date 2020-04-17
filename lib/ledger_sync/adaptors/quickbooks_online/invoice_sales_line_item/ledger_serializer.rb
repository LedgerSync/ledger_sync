# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module InvoiceSalesLineItem
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'DetailType' do
            'SalesItemLineDetail'
          end

          attribute ledger_attribute: 'SalesItemLineDetail.ItemRef.value',
                    resource_attribute: 'item.ledger_id'

          attribute ledger_attribute: 'SalesItemLineDetail.ClassRef.value',
                    resource_attribute: 'ledger_class.ledger_id'

          attribute ledger_attribute: 'Amount',
                    resource_attribute: :amount,
                    type: Adaptors::LedgerSerializerType::AmountType

          attribute ledger_attribute: 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end
