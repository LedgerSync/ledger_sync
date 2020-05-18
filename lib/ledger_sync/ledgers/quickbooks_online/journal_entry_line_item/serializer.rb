# frozen_string_literal: true

require_relative '../expense_line_item/serializer'

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

          attribute 'JournalEntryLineDetail.AccountRef.value',
                    resource_attribute: 'account.ledger_id'

          attribute 'JournalEntryLineDetail.ClassRef.value',
                    resource_attribute: 'ledger_class.ledger_id'

          attribute 'JournalEntryLineDetail.DepartmentRef.value',
                    resource_attribute: 'department.ledger_id'

          attribute 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end
