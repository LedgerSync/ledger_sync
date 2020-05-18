# frozen_string_literal: true

require_relative '../currency/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Transfer
        class Serializer < QuickBooksOnline::Serializer
          id

          amount 'Amount',
                 resource_attribute: :amount

          attribute 'PrivateNote',
                    resource_attribute: :memo

          attribute 'FromAccountRef.value',
                    resource_attribute: 'from_account.ledger_id'

          attribute 'ToAccountRef.value',
                    resource_attribute: 'to_account.ledger_id'

          date 'TxnDate',
               resource_attribute: :transaction_date

          references_one :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::Serializer
        end
      end
    end
  end
end
