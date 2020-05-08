# frozen_string_literal: true

require_relative '../currency/serializer'
require_relative '../journal_entry_line_item/serializer'

module LedgerSync
  module Ledgers
    module NetSuite
      class JournalEntry
        class Serializer < NetSuite::Serializer
          id

          attribute :memo

          attribute :trandate

          attribute :tranId

          references_one :currency,
                         resource_attribute: :currency,
                         serializer: Currency::Serializer

           references_many 'line.items',
                           resource_attribute: :line_items,
                           serializer: JournalEntryLineItem::Serializer

        end
      end
    end
  end
end
