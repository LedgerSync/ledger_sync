# frozen_string_literal: true

require_relative '../expense_line_item/ledger_serializer'
require_relative '../reference/ledger_serializer'

module LedgerSync
  module Adaptors
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

          references_one ledger_attribute: 'JournalEntryLineDetail.AccountRef',
                         resource_attribute: :account,
                         resource_class: LedgerSync::Account,
                         serializer: Reference::LedgerSerializer

          references_one ledger_attribute: 'JournalEntryLineDetail.ClassRef',
                         resource_attribute: :ledger_class,
                         resource_class: LedgerSync::LedgerClass,
                         serializer: Reference::LedgerSerializer

          references_one ledger_attribute: 'JournalEntryLineDetail.DepartmentRef',
                         resource_attribute: :department,
                         resource_class: LedgerSync::Department,
                         serializer: Reference::LedgerSerializer

          attribute ledger_attribute: 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end
