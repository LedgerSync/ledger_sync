# frozen_string_literal: true

require_relative '../expense_line_item/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntryLineItem
        class Deserializer < QuickBooksOnline::Deserializer
          amount :amount,
                 hash_attribute: 'Amount'

          mapping :entry_type,
                  hash_attribute: 'JournalEntryLineDetail.PostingType',
                  hash: JournalEntryLineItem::TYPES.invert

          attribute 'account.ledger_id',
                    hash_attribute: 'JournalEntryLineDetail.AccountRef.value'

          attribute 'ledger_class.ledger_id',
                    hash_attribute: 'JournalEntryLineDetail.ClassRef.value'

          attribute 'department.ledger_id',
                    hash_attribute: 'JournalEntryLineDetail.DepartmentRef.value'

          attribute :description,
                    hash_attribute: 'Description'
        end
      end
    end
  end
end
