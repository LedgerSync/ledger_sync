# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module LedgerClass
        class LedgerSerializer < NetSuite::LedgerSerializer
          api_resource_type :department

          attribute ledger_attribute: :name,
                    resource_attribute: :name

          attribute ledger_attribute: :subsidiary,
                    resource_attribute: :subsidiary,
                    type: LedgerSerializerType::ReferenceType

        end
      end
    end
  end
end
