# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Location
        class LedgerSerializer < NetSuite::LedgerSerializer
          id

          attribute ledger_attribute: :name,
                    resource_attribute: :name
        end
      end
    end
  end
end
