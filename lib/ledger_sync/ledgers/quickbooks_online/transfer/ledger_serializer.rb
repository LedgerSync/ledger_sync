# frozen_string_literal: true

require_relative '../currency/ledger_serializer'

module LedgerSync
  module Ledgers
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

          references_one ledger_attribute: :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::LedgerSerializer
        end
      end
    end
  end
end
