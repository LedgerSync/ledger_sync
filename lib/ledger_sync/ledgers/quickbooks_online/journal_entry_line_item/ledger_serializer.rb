# frozen_string_literal: true

require_relative '../expense_line_item/ledger_serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module JournalEntryLineItem
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: 'DetailType' do
            'JournalEntryLineDetail'
          end

          attribute ledger_attribute: 'Amount',
                    resource_attribute: :amount,
                    type: LedgerSerializerType::AmountType

          attribute ledger_attribute: 'JournalEntryLineDetail.PostingType',
                    resource_attribute: :entry_type,
                    type: LedgerSerializerType::JournalEntryLineItemType

          attribute ledger_attribute: 'JournalEntryLineDetail.AccountRef.value',
                    resource_attribute: 'account.ledger_id'

          attribute ledger_attribute: 'JournalEntryLineDetail.ClassRef.value',
                    resource_attribute: 'ledger_class.ledger_id'

          attribute ledger_attribute: 'JournalEntryLineDetail.DepartmentRef.value',
                    resource_attribute: 'department.ledger_id'

          attribute ledger_attribute: 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end
