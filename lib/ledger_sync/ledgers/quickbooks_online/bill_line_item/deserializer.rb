# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillLineItem
        class Deserializer < QuickBooksOnline::Deserializer
          id

          references_one :account,
                         hash_attribute: 'AccountBasedExpenseLineDetail.AccountRef',
                         deserializer: Reference::Deserializer

          references_one :ledger_class,
                         hash_attribute: 'AccountBasedExpenseLineDetail.ClassRef',
                         deserializer: Reference::Deserializer

          amount :amount,
                 hash_attribute: 'Amount'

          attribute :description,
                    hash_attribute: 'Description'
        end
      end
    end
  end
end
