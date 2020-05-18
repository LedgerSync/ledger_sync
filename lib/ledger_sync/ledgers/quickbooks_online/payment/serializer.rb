# frozen_string_literal: true

require_relative '../currency/serializer'
require_relative '../payment_line_item/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Payment
        class Serializer < QuickBooksOnline::Serializer
          id

          amount 'TotalAmt',
                 resource_attribute: :amount

          references_one :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::Serializer

          attribute 'CustomerRef.value',
                    resource_attribute: 'customer.ledger_id'

          attribute 'DepositToAccountRef.value',
                    resource_attribute: 'deposit_account.ledger_id'

          attribute 'ARAccountRef.value',
                    resource_attribute: 'account.ledger_id'

          attribute 'PaymentRefNum',
                    resource_attribute: :reference_number

          attribute 'PrivateNote',
                    resource_attribute: :memo

          attribute 'ExchangeRate',
                    resource_attribute: :exchange_rate

          date 'TxnDate',
               resource_attribute: :transaction_date

          references_many 'Line',
                          resource_attribute: :line_items,
                          serializer: PaymentLineItem::Serializer
        end
      end
    end
  end
end
