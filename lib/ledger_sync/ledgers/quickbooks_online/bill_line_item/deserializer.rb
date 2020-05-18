# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillLineItem
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute 'account.ledger_id',
                    hash_attribute: 'AccountBasedExpenseLineDetail.AccountRef.value'

          attribute 'ledger_class.ledger_id',
                    hash_attribute: 'AccountBasedExpenseLineDetail.ClassRef.value'

          amount :amount,
                 hash_attribute: 'Amount'

          attribute :description,
                    hash_attribute: 'Description'
        end
      end
    end
  end
end
