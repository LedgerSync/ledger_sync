# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class PaymentLine
        class Deserializer < QuickBooksOnline::Deserializer
          amount :Amount

          attribute :LinkedTxn,
                    hash_attribute: 'LinkedTxn',
                    type: Serialization::Type::DeserializeTransactionReferenceType.new
        end
      end
    end
  end
end
