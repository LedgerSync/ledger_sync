# frozen_string_literal: true

require_relative '../reference/serializer'
require_relative '../payment_line_item/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Payment
        class Serializer < QuickBooksOnline::Serializer
          id

          amount 'TotalAmt',
                 resource_attribute: :amount

          references_one 'CurrencyRef',
                         resource_attribute: :currency,
                         serializer: Reference::Serializer

          references_one 'CustomerRef',
                         resource_attribute: :customer,
                         serializer: Reference::Serializer

          references_one 'DepositToAccountRef',
                         resource_attribute: :deposit_account,
                         serializer: Reference::Serializer

          references_one 'ARAccountRef',
                         resource_attribute: :account,
                         serializer: Reference::Serializer

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
