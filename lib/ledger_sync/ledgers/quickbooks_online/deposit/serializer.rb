# frozen_string_literal: true

require_relative '../deposit_line_item/serializer'
require_relative '../currency/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Deposit
        class Serializer < QuickBooksOnline::Serializer
          id

          references_one :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::Serializer

          date 'TxnDate',
               resource_attribute: :transaction_date

          attribute 'PrivateNote',
                    resource_attribute: :memo

          attribute 'ExchangeRate',
                    resource_attribute: :exchange_rate

          attribute 'DepositToAccountRef.value',
                    resource_attribute: 'account.ledger_id'

          attribute 'DepartmentRef.value',
                    resource_attribute: 'department.ledger_id'

          references_many 'Line',
                          resource_attribute: :line_items,
                          serializer: DepositLineItem::Serializer
        end
      end
    end
  end
end
