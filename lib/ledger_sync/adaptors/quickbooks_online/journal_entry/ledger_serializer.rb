# frozen_string_literal: true

require_relative '../journal_entry_line_item/ledger_serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module JournalEntry
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          references_one ledger_attribute: :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::LedgerSerializer

          attribute ledger_attribute: 'TxnDate',
                    resource_attribute: :transaction_date,
                    type: LedgerSerializerType::DateType

          attribute ledger_attribute: 'PrivateNote',
                    resource_attribute: :memo

          attribute ledger_attribute: 'DocNumber',
                    resource_attribute: :reference_number

          references_many ledger_attribute: 'Line',
                          resource_attribute: :line_items,
                          serializer: JournalEntryLineItem::LedgerSerializer
        end
      end
    end
  end
end
