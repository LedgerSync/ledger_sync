# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerSerializerType
        class JournalEntryLineItemType < Ledgers::LedgerSerializerType::MappingType
          MAPPING = {
            'debit' => 'Debit',
            'credit' => 'Credit'
          }.freeze

          def self.mapping
            @mapping ||= MAPPING
          end
        end
      end
    end
  end
end
