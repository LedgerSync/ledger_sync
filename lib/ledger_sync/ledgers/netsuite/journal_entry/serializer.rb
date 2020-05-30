# frozen_string_literal: true

require_relative '../reference/serializer'
require_relative '../journal_entry_line_item/serializer'

module LedgerSync
  module Ledgers
    module NetSuite
      class JournalEntry
        class Serializer < NetSuite::Serializer
          attribute :memo

          attribute :trandate

          attribute :tranId

          references_one :currency

          references_one :subsidiary

          references_many 'line.items',
                          resource_attribute: :line_items,
                          serializer: JournalEntryLineItem::Serializer

        end
      end
    end
  end
end
