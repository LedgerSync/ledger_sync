# frozen_string_literal: true

require_relative '../reference/deserializer'
require_relative '../journal_entry_line/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntry
        class Deserializer < QuickBooksOnline::Deserializer
          id

          date :TxnDate
          attribute :PrivateNote
          attribute :DocNumber

          references_one :Currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          references_many :Line,
                          hash_attribute: 'Line',
                          deserializer: JournalEntryLine::Deserializer
        end
      end
    end
  end
end
