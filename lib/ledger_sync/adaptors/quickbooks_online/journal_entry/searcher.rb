# frozen_string_literal: true
require_relative '../searcher'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module JournalEntry
        class Searcher < QuickBooksOnline::Searcher
          def resources
            @resources ||= begin
              adaptor
                .query(
                  resource: 'journal_entry',
                  limit: limit,
                  offset: offset
                )
                .map do |c|
                  LedgerSync::JournalEntry.new(
                    ledger_id: c.fetch('Id')
                  )
                end
            end
          end
        end
      end
    end
  end
end
