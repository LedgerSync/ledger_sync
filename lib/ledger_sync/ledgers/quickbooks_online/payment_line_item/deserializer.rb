# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class PaymentLineItem
        class Deserializer < QuickBooksOnline::Deserializer
          amount :amount,
                 hash_attribute: 'Amount'

          attribute :ledger_transactions,
                    hash_attribute: 'LinkedTxn',
                    type: Serialization::Type::DeserializeTransactionReferenceType.new
        end
      end
    end
  end
end
