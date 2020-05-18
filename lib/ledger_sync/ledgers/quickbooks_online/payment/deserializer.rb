# frozen_string_literal: true

require_relative '../currency/deserializer'
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
                         hash_attribute: :CurrencyRef,
                         deserializer: Currency::Deserializer

          attribute 'customer.ledger_id',
                    hash_attribute: 'CustomerRef.value'

          attribute 'deposit_account.ledger_id',
                    hash_attribute: 'DepositToAccountRef.value'

          attribute 'account.ledger_id',
                    hash_attribute: 'ARAccountRef.value'

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
