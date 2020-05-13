# frozen_string_literal: true

require_relative 'currency'
require_relative 'journal_entry_line_item'

module LedgerSync
  module Bundles
    module ModernTreasury
      class JournalEntry < ModernTreasury::Resource
    attribute :memo, type: Type::String
    attribute :transaction_date, type: Type::Date
    attribute :reference_number, type: Type::String

    references_one :currency, to: Currency

    references_many :line_items, to: JournalEntryLineItem

    def name
      "JournalEntry: #{transaction_date}"
    end
      end
    end
  end
end
