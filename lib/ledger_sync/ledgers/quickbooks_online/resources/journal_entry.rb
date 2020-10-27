# frozen_string_literal: true

require_relative 'currency'
require_relative 'journal_entry_line'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntry < QuickBooksOnline::Resource
        attribute :PrivateNote, type: Type::String
        attribute :TxnDate, type: Type::Date
        attribute :DocNumber, type: Type::String

        references_one :Currency, to: Currency

        references_many :Line, to: JournalEntryLine

        def name
          "JournalEntry: #{self.TxnDate}"
        end
      end
    end
  end
end
