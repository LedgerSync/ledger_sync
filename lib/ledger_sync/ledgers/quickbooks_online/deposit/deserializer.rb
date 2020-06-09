# frozen_string_literal: true

require_relative '../deposit_line_item/deserializer'
require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Deposit
        class Deserializer < QuickBooksOnline::Deserializer
          id

          references_one :currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          date :transaction_date,
               hash_attribute: 'TxnDate'

          attribute :memo,
                    hash_attribute: 'PrivateNote'

          attribute :exchange_rate,
                    hash_attribute: 'ExchangeRate'

          references_one :account,
                         hash_attribute: 'DepositToAccountRef',
                         deserializer: Reference::Deserializer

          references_one :department,
                         hash_attribute: 'DepartmentRef',
                         deserializer: Reference::Deserializer

          references_many :line_items,
                          hash_attribute: 'Line',
                          deserializer: DepositLineItem::Deserializer
        end
      end
    end
  end
end
