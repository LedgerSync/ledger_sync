# frozen_string_literal: true

require_relative '../currency/deserializer'
require_relative '../subsidiary/deserializer'
require_relative '../journal_entry_line_item/deserializer'

module LedgerSync
  module Ledgers
    module NetSuite
      class JournalEntry
        class Deserializer < NetSuite::Deserializer
          id

          attribute :memo

          attribute :trandate

          attribute :tranId

          references_one :currency

          references_one :subsidiary

          references_many :line_items,
                          hash_attribute: 'line.items',
                          deserializer: JournalEntryLineItem::Deserializer
        end
      end
    end
  end
end
