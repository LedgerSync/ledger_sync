# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntryLineDetail
        class Deserializer < QuickBooksOnline::Deserializer
          mapping :PostingType,
                  hash_attribute: 'PostingType',
                  hash: JournalEntryLineDetail::TYPES.invert

          references_one :Account,
                         hash_attribute: 'AccountRef',
                         deserializer: Reference::Deserializer

          references_one :Class,
                         hash_attribute: 'ClassRef',
                         deserializer: Reference::Deserializer

          references_one :Department,
                         hash_attribute: 'DepartmentRef',
                         deserializer: Reference::Deserializer
        end
      end
    end
  end
end
