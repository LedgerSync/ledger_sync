# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntryLineItem
        class Serializer < QuickBooksOnline::Serializer
          attribute 'DetailType' do
            'JournalEntryLineDetail'
          end

          amount 'Amount',
                 resource_attribute: :amount

          mapping 'JournalEntryLineDetail.PostingType',
                  resource_attribute: :entry_type,
                  hash: JournalEntryLineItem::TYPES

          references_one 'JournalEntryLineDetail.AccountRef',
                         resource_attribute: :account,
                         serializer: Reference::Serializer

          references_one 'JournalEntryLineDetail.ClassRef',
                         resource_attribute: :ledger_class,
                         serializer: Reference::Serializer

          references_one 'JournalEntryLineDetail.DepartmentRef',
                         resource_attribute: :department,
                         serializer: Reference::Serializer

          attribute 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end
