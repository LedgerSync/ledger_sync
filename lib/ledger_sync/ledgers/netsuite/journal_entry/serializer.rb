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

          references_one :currency,
                         resource_attribute: :currency,
                         serializer: Reference::Serializer

          references_one :subsidiary,
                         resource_attribute: :subsidiary,
                         serializer: Reference::Serializer

          references_many 'line.items',
                          resource_attribute: :line_items,
                          serializer: JournalEntryLineItem::Serializer

        end
      end
    end
  end
end
