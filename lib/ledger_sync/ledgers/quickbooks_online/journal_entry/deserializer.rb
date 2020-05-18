# frozen_string_literal: true

require_relative '../currency/deserializer'
require_relative '../journal_entry_line_item/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntry
        class Deserializer < QuickBooksOnline::Deserializer
          id

          references_one :currency,
                         hash_attribute: :CurrencyRef,
                         deserializer: Currency::Deserializer

          date :transaction_date,
               hash_attribute: 'TxnDate'

          attribute :memo,
                    hash_attribute: 'PrivateNote'

          attribute :reference_number,
                    hash_attribute: 'DocNumber'

          references_many :line_items,
                          hash_attribute: 'Line',
                          deserializer: JournalEntryLineItem::Deserializer
        end
      end
    end
  end
end
