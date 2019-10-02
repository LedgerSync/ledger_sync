module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Expense
        module Mapping
          PAYMENT_TYPES = {
            'cash' => 'Cash',
            'check' => 'Check',
            'credit_card' => 'CreditCard',
          }
        end
      end
    end
  end
end