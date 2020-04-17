# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module BillPaymentLineItem
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: 'Amount',
                    resource_attribute: :amount,
                    type: Adaptors::LedgerSerializerType::AmountType

          attribute ledger_attribute: 'LinkedTxn',
                    resource_attribute: :ledger_transactions,
                    type: LedgerSerializerType::TransactionReferenceType
        end
      end
    end
  end
end
