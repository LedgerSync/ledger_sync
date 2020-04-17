# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Item
        class LedgerSerializer < NetSuite::LedgerSerializer
          id

          attribute ledger_attribute: :name,
                    resource_attribute: :name

          attribute ledger_attribute: :type,
                    resource_attribute: :type,
                    type: LedgerSerializerType::Item::TypeType
        end
      end
    end
  end
end
