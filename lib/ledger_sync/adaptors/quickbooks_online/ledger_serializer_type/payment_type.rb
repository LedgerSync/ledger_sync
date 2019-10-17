# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class PaymentType < Adaptors::LedgerSerializerType::MappingType
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
