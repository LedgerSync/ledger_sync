# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Transfer
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'Amount',
                    resource_attribute: :amount,
                    type: LedgerSerializerType::AmountType

          attribute ledger_attribute: 'PrivateNote',
                    resource_attribute: :memo

          attribute ledger_attribute: 'FromAccountRef.value',
                    resource_attribute: 'from_account.ledger_id'

          attribute ledger_attribute: 'ToAccountRef.value',
                    resource_attribute: 'to_account.ledger_id'

          attribute ledger_attribute: 'TxnDate',
                    resource_attribute: :transaction_date,
                    type: LedgerSerializerType::DateType

          attribute ledger_attribute: 'CurrencyRef.value',
                    resource_attribute: 'currency'
        end
      end
    end
  end
end
