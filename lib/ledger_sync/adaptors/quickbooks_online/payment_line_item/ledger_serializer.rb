# frozen_string_literal: true

require_relative '../txn/ledger_serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module PaymentLineItem
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: 'Amount',
                    resource_attribute: :amount,
                    type: LedgerSerializerType::AmountType

          references_many ledger_attribute: 'LinkedTxn',
                    resource_attribute: :linked_txns,
                    serializer: Txn::LedgerSerializer
        end
      end
    end
  end
end
