# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Reference
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: :value,
                    resource_attribute: :ledger_id

          attribute ledger_attribute: :name,
                    resource_attribute: :name,
                    deserialize: false
        end
      end
    end
  end
end
