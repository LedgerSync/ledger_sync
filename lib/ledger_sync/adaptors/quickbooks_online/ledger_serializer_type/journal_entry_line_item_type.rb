# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class JournalEntryLineItemType < Adaptors::LedgerSerializerType::MappingType
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
