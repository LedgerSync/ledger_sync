# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntryLineDetail
        class Serializer < QuickBooksOnline::Serializer
          mapping 'PostingType',
                  resource_attribute: :PostingType,
                  hash: JournalEntryLineDetail::TYPES

          references_one 'AccountRef',
                         resource_attribute: :Account,
                         serializer: Reference::Serializer

          references_one 'ClassRef',
                         resource_attribute: :Class,
                         serializer: Reference::Serializer

          references_one 'DepartmentRef',
                         resource_attribute: :Department,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end
