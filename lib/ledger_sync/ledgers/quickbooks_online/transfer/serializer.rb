# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Transfer
        class Serializer < QuickBooksOnline::Serializer
          id

          amount :Amount
          attribute :PrivateNote
          date :TxnDate

          references_one 'FromAccountRef',
                         resource_attribute: :FromAccount,
                         serializer: Reference::Serializer

          references_one 'ToAccountRef',
                         resource_attribute: :ToAccount,
                         serializer: Reference::Serializer

          references_one 'CurrencyRef',
                         resource_attribute: :Currency,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end
