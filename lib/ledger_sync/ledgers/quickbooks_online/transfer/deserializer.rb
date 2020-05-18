# frozen_string_literal: true

require_relative '../currency/deserializer'

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

          attribute 'from_account.ledger_id',
                    hash_attribute: 'FromAccountRef.value'

          attribute 'to_account.ledger_id',
                    hash_attribute: 'ToAccountRef.value'

          date :transaction_date,
               hash_attribute: 'TxnDate'

          references_one :currency,
                         hash_attribute: :CurrencyRef,
                         deserializer: Currency::Deserializer
        end
      end
    end
  end
end
