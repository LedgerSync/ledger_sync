# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module InvoiceSalesLineItem
        class LedgerSerializer < NetSuite::LedgerSerializer
          attribute ledger_attribute: :amount,
                    resource_attribute: :amount

          attribute ledger_attribute: :description,
                    resource_attribute: :description
        end
      end
    end
  end
end
