# frozen_string_literal: true

require_relative '../deposit_line_item/serializer'
require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Deposit
        class Serializer < QuickBooksOnline::Serializer
          id

          references_one 'CurrencyRef',
                         resource_attribute: :currency,
                         serializer: Reference::Serializer

          date 'TxnDate',
               resource_attribute: :transaction_date

          attribute 'PrivateNote',
                    resource_attribute: :memo

          attribute 'ExchangeRate',
                    resource_attribute: :exchange_rate

          references_one 'DepositToAccountRef',
                         resource_attribute: :account,
                         serializer: Reference::Serializer

          references_one 'DepartmentRef',
                         resource_attribute: :department,
                         serializer: Reference::Serializer

          references_many 'Line',
                          resource_attribute: :line_items,
                          serializer: DepositLineItem::Serializer
        end
      end
    end
  end
end
