# frozen_string_literal: true

require_relative '../invoice_sales_line_item/serializer'
require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Invoice
        class Serializer < QuickBooksOnline::Serializer
          id

          references_one 'CurrencyRef',
                         resource_attribute: :currency,
                         serializer: Reference::Serializer

          date 'TxnDate',
               resource_attribute: :transaction_date

          attribute 'PrivateNote',
                    resource_attribute: :memo

          references_one 'CustomerRef',
                         resource_attribute: :customer,
                         serializer: Reference::Serializer

          references_one 'DepositToAccountRef',
                         resource_attribute: :account,
                         serializer: Reference::Serializer

          references_many 'Line',
                          resource_attribute: :line_items,
                          serializer: InvoiceSalesLineItem::Serializer
        end
      end
    end
  end
end
