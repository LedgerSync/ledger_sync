# frozen_string_literal: true

require_relative '../reference/deserializer'
require_relative '../payment_line/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Payment
        class Deserializer < QuickBooksOnline::Deserializer
          id

          amount :TotalAmt
          attribute :PaymentRefNum
          attribute :PrivateNote
          attribute :ExchangeRate
          date :TxnDate

          references_one :Currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          references_one :Customer,
                         hash_attribute: 'CustomerRef',
                         deserializer: Reference::Deserializer

          references_one :DepositToAccount,
                         hash_attribute: 'DepositToAccountRef',
                         deserializer: Reference::Deserializer

          references_one :ARAccount,
                         hash_attribute: 'ARAccountRef',
                         deserializer: Account::Deserializer

          references_many :Line,
                          hash_attribute: 'Line',
                          deserializer: PaymentLine::Deserializer
        end
      end
    end
  end
end
