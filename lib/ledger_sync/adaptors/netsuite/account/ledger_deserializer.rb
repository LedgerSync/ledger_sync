# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Account
        class LedgerDeserializer < NetSuite::LedgerSerializer
          attribute ledger_attribute: :id,
                    resource_attribute: :ledger_id

          attribute ledger_attribute: :acctname,
                    resource_attribute: :name
        end
      end
    end
  end
end
