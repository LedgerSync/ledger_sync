# frozen_string_literal: true

require_relative 'journal_entry_line_detail'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntryLine < QuickBooksOnline::Resource
        attribute :Amount, type: Type::Integer
        attribute :Description, type: Type::String

        references_one :JournalEntryLineDetail, to: JournalEntryLineDetail

        def name
          self.Description
        end
      end
    end
  end
end
