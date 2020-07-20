# frozen_string_literal: true

require_relative '../journal_entry_line_detail/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntryLine
        class Deserializer < QuickBooksOnline::Deserializer
          amount :Amount
          attribute :Description

          references_one :JournalEntryLineDetail,
                         hash_attribute: 'JournalEntryLineDetail',
                         deserializer: JournalEntryLineDetail::Deserializer
        end
      end
    end
  end
end
