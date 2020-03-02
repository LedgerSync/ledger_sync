# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Department
        class LedgerDeserializer < NetSuite::LedgerSerializer
          attribute ledger_attribute: :name,
                    resource_attribute: :name
        end
      end
    end
  end
end
