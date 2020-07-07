# frozen_string_literal: true

require_relative '../reference/deserializer'

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

          references_one :account,
                         hash_attribute: 'JournalEntryLineDetail.AccountRef',
                         deserializer: Reference::Deserializer

          references_one :ledger_class,
                         hash_attribute: 'JournalEntryLineDetail.ClassRef',
                         deserializer: Reference::Deserializer

          references_one :department,
                         hash_attribute: 'JournalEntryLineDetail.DepartmentRef',
                         deserializer: Reference::Deserializer

          attribute :description,
                    hash_attribute: 'Description'
        end
      end
    end
  end
end
