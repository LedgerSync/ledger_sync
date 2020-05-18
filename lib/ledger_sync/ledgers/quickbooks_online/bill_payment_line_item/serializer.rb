# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPaymentLineItem
        class Serializer < QuickBooksOnline::Serializer
          amount 'Amount',
                 resource_attribute: :amount

          attribute 'LinkedTxn',
                    resource_attribute: :ledger_transactions,
                    type: Serialization::Type::SerializeTransactionReferenceType.new
        end
      end
    end
  end
end
