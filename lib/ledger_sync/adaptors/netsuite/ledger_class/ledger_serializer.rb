# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module LedgerClass
        class LedgerSerializer < NetSuite::LedgerSerializer
          api_resource_type :ledger_class

          attribute ledger_attribute: :name,
                    resource_attribute: :name
        end
      end
    end
  end
end
