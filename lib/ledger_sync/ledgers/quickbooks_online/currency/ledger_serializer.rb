# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Currency
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: :value,
                    resource_attribute: :symbol

          attribute ledger_attribute: :name,
                    resource_attribute: :name
        end
      end
    end
  end
end
