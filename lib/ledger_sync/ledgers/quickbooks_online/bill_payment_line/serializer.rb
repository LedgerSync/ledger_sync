# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPaymentLine
        class Serializer < QuickBooksOnline::Serializer
          amount :Amount

          attribute :LinkedTxn,
                    type: Serialization::Type::SerializeTransactionReferenceType.new
        end
      end
    end
  end
end
