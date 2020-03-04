# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Department
        class LedgerSerializer < NetSuite::LedgerSerializer
          api_resource_type :department

          attribute ledger_attribute: :name,
                    resource_attribute: :name

        end
      end
    end
  end
end
