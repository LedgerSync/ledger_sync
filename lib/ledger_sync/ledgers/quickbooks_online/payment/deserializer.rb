# frozen_string_literal: true

require_relative '../reference/deserializer'
require_relative '../payment_line_item/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Payment
        class Deserializer < QuickBooksOnline::Deserializer
          id

          amount :amount,
                 hash_attribute: 'TotalAmt'

          references_one :currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          references_one :customer,
                         hash_attribute: 'CustomerRef',
                         deserializer: Reference::Deserializer

          references_one :deposit_account,
                         hash_attribute: 'DepositToAccountRef',
                         deserializer: Reference::Deserializer

          references_one :account,
                         hash_attribute: 'ARAccountRef',
                         deserializer: Account::Deserializer

          attribute :reference_number,
                    hash_attribute: 'PaymentRefNum'

          attribute :memo,
                    hash_attribute: 'PrivateNote'

          attribute :exchange_rate,
                    hash_attribute: 'ExchangeRate'

          date :transaction_date,
               hash_attribute: 'TxnDate'

          references_many :line_items,
                          hash_attribute: 'Line',
                          deserializer: PaymentLineItem::Deserializer
        end
      end
    end
  end
end
