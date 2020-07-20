# frozen_string_literal: true

require_relative '../reference/serializer'
require_relative '../journal_entry_line/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntry
        class Serializer < QuickBooksOnline::Serializer
          id

          date :TxnDate
          attribute :PrivateNote
          attribute :DocNumber

          references_one 'CurrencyRef',
                         resource_attribute: :Currency,
                         serializer: Reference::Serializer

          references_many 'Line',
                          resource_attribute: :Line,
                          serializer: JournalEntryLine::Serializer
        end
      end
    end
  end
end
