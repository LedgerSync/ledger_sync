# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class PaymentLine
        class Serializer < QuickBooksOnline::Serializer
          amount :Amount

          attribute 'LinkedTxn',
                    resource_attribute: :LinkedTxn,
                    type: Serialization::Type::SerializeTransactionReferenceType.new
        end
      end
    end
  end
end
