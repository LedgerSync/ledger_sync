# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerSerializerType
        class PaymentType < Ledgers::LedgerSerializerType::MappingType
          MAPPING = {
            'cash' => 'Cash',
            'check' => 'Check',
            'credit_card' => 'CreditCard'
          }.freeze

          def self.mapping
            @mapping ||= MAPPING
          end
        end
      end
    end
  end
end
