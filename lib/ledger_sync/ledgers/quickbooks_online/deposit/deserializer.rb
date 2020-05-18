# frozen_string_literal: true

require_relative '../deposit_line_item/deserializer'
require_relative '../currency/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Deposit
        class Deserializer < QuickBooksOnline::Deserializer
          id

          references_one :currency,
                         hash_attribute: :CurrencyRef,
                         deserializer: Currency::Deserializer

          date :transaction_date,
               hash_attribute: 'TxnDate'

          attribute :memo,
                    hash_attribute: 'PrivateNote'

          attribute :exchange_rate,
                    hash_attribute: 'ExchangeRate'

          attribute 'account.ledger_id',
                    hash_attribute: 'DepositToAccountRef.value'

          attribute 'department.ledger_id',
                    hash_attribute: 'DepartmentRef.value'

          references_many :line_items,
                          hash_attribute: 'Line',
                          deserializer: DepositLineItem::Deserializer
        end
      end
    end
  end
end
