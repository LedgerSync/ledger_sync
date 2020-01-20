# frozen_string_literal: true

require_relative 'journal_entry_line_item'

module LedgerSync
  class JournalEntry < LedgerSync::Resource
    attribute :currency, type: Type::String
    attribute :memo, type: Type::String
    attribute :transaction_date, type: Type::Date
    attribute :reference_number, type: Type::String

    references_many :line_items, to: JournalEntryLineItem

    def name
      "JournalEntry: #{transaction_date}"
    end
  end
end
