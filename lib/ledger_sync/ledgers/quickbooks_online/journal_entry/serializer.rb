# frozen_string_literal: true

require_relative '../reference/serializer'
require_relative '../journal_entry_line_item/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntry
        class Serializer < QuickBooksOnline::Serializer
          id

          references_one 'CurrencyRef',
                         resource_attribute: :currency,
                         serializer: Reference::Serializer

          date 'TxnDate',
               resource_attribute: :transaction_date

          attribute 'PrivateNote',
                    resource_attribute: :memo

          attribute 'DocNumber',
                    resource_attribute: :reference_number

          references_many 'Line',
                          resource_attribute: :line_items,
                          serializer: JournalEntryLineItem::Serializer
        end
      end
    end
  end
end
