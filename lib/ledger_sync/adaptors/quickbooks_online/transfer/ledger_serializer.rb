# frozen_string_literal: true

require_relative '../currency/ledger_serializer'
require_relative '../reference/ledger_serializer'

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

          references_one ledger_attribute: 'FromAccountRef',
                         resource_attribute: :from_account,
                         resource_class: LedgerSync::Account,
                         serializer: Reference::LedgerSerializer

          references_one ledger_attribute: 'ToAccountRef',
                         resource_attribute: :to_account,
                         resource_class: LedgerSync::Account,
                         serializer: Reference::LedgerSerializer

          attribute ledger_attribute: 'TxnDate',
                    resource_attribute: :transaction_date,
                    type: LedgerSerializerType::DateType

          references_one ledger_attribute: 'CurrencyRef',
                         resource_attribute: :currency,
                         serializer: Currency::LedgerSerializer
        end
      end
    end
  end
end
