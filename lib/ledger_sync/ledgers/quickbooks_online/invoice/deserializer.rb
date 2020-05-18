# frozen_string_literal: true

require_relative '../invoice_sales_line_item/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Invoice
        class Deserializer < QuickBooksOnline::Deserializer
          id

          references_one :currency,
                         hash_attribute: :CurrencyRef,
                         deserializer: Currency::Deserializer

          date :transaction_date,
               hash_attribute: 'TxnDate'

          attribute :memo,
                    hash_attribute: 'PrivateNote'

          attribute 'customer.ledger_id',
                    hash_attribute: 'CustomerRef.value'

          attribute 'account.ledger_id',
                    hash_attribute: 'DepositToAccountRef.value'

          references_many :line_items,
                          hash_attribute: 'Line',
                          deserializer: InvoiceSalesLineItem::Deserializer
        end
      end
    end
  end
end
