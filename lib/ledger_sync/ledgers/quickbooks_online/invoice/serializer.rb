# frozen_string_literal: true

require_relative '../invoice_sales_line_item/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Invoice
        class Serializer < QuickBooksOnline::Serializer
          id

          references_one :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::Serializer

          date 'TxnDate',
               resource_attribute: :transaction_date

          attribute 'PrivateNote',
                    resource_attribute: :memo

          attribute 'CustomerRef.value',
                    resource_attribute: 'customer.ledger_id'

          attribute 'DepositToAccountRef.value',
                    resource_attribute: 'account.ledger_id'

          references_many 'Line',
                          resource_attribute: :line_items,
                          serializer: InvoiceSalesLineItem::Serializer
        end
      end
    end
  end
end
