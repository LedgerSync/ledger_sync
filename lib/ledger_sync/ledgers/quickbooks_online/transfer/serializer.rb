# frozen_string_literal: true

require_relative '../reference/serializer'

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

          references_one 'FromAccountRef',
                         resource_attribute: :from_account,
                         serializer: Reference::Serializer

          references_one 'ToAccountRef',
                         resource_attribute: :to_account,
                         serializer: Reference::Serializer

          date 'TxnDate',
               resource_attribute: :transaction_date

          references_one 'CurrencyRef',
                         resource_attribute: :currency,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end
