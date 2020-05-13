# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPaymentLineItem
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: 'Amount',
                    resource_attribute: :amount,
                    type: LedgerSerializerType::AmountType

          attribute ledger_attribute: 'LinkedTxn',
                    resource_attribute: :ledger_transactions,
                    type: LedgerSerializerType::TransactionReferenceType
        end
      end
    end
  end
end
