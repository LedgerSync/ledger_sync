# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class Classification < Adaptors::LedgerSerializerType::Mapping
          MAPPING = {
            'asset' => 'Asset',
            'equity' => 'Equity',
            'expense' => 'Expense',
            'liability' => 'Liability',
            'revenue' => 'Revenue'
          }.freeze

          def self.mapping
            @mapping ||= MAPPING
          end
        end
      end
    end
  end
end
