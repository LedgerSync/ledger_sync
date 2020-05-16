# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerSerializerType
        class AccountType < Ledgers::LedgerSerializerType::MappingType
          def self.mapping
            @mapping ||= QuickBooksOnline::Account::TYPES
          end
        end
      end
    end
  end
end
