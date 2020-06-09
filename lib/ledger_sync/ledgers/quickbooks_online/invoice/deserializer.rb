# frozen_string_literal: true

require_relative '../invoice_sales_line_item/deserializer'
require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Invoice
        class Deserializer < QuickBooksOnline::Deserializer
          id

          references_one :currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          date :transaction_date,
               hash_attribute: 'TxnDate'

          attribute :memo,
                    hash_attribute: 'PrivateNote'

          references_one :customer,
                         hash_attribute: 'CustomerRef',
                         deserializer: Reference::Deserializer

          references_one :account,
                         hash_attribute: 'DepositToAccountRef',
                         deserialier: Reference::Deserializer

          references_many :line_items,
                          hash_attribute: 'Line',
                          deserializer: InvoiceSalesLineItem::Deserializer
        end
      end
    end
  end
end
