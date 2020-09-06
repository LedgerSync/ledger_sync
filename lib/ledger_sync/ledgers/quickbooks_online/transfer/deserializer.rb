# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Transfer
        class Deserializer < QuickBooksOnline::Deserializer
          id

          amount :Amount
          attribute :PrivateNote
          date :TxnDate

          references_one :FromAccount,
                         hash_attribute: 'FromAccountRef',
                         deserializer: Reference::Deserializer

          references_one :ToAccount,
                         hash_attribute: 'ToAccountRef',
                         deserializer: Reference::Deserializer

          references_one :Currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer
        end
      end
    end
  end
end
