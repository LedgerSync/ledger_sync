# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class InvoiceSalesLineItem
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute 'item.ledger_id',
                    hash_attribute: 'SalesItemLineDetail.ItemRef.value'

          attribute 'ledger_class.ledger_id',
                    hash_attribute: 'SalesItemLineDetail.ClassRef.value'

          amount :amount,
                 hash_attribute: 'Amount'

          attribute :description,
                    hash_attribute: 'Description'
        end
      end
    end
  end
end
