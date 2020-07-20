# frozen_string_literal: true

require_relative '../deposit_line/deserializer'
require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Deposit
        class Deserializer < QuickBooksOnline::Deserializer
          id

          date :TxnDate
          attribute :PrivateNote
          attribute :ExchangeRate

          references_one :Currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          references_one :DepositToAccount,
                         hash_attribute: 'DepositToAccountRef',
                         deserializer: Reference::Deserializer

          references_one :Department,
                         hash_attribute: 'DepartmentRef',
                         deserializer: Reference::Deserializer

          references_many :Line,
                          hash_attribute: 'Line',
                          deserializer: DepositLine::Deserializer
        end
      end
    end
  end
end
