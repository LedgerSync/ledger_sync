# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Transfer
        class Deserializer < QuickBooksOnline::Deserializer
          id

          amount :amount,
                 hash_attribute: 'Amount'

          attribute :memo,
                    hash_attribute: 'PrivateNote'

          references_one :from_account,
                         hash_attribute: 'FromAccountRef',
                         deserializer: Reference::Deserializer

          references_one :to_account,
                         hash_attribute: 'ToAccountRef',
                         deserializer: Reference::Deserializer

          date :transaction_date,
               hash_attribute: 'TxnDate'

          references_one :currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer
        end
      end
    end
  end
end
