# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Payment
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'TotalAmt',
                    resource_attribute: :amount,
                    type: LedgerSerializerType::AmountType

          attribute ledger_attribute: 'CurrencyRef.value',
                    resource_attribute: :currency

          attribute ledger_attribute: 'CustomerRef.value',
                    resource_attribute: 'customer.ledger_id'
        end
      end
    end
  end
end
