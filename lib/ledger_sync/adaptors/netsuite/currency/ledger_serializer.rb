# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Currency
        class LedgerSerializer < NetSuite::LedgerSerializer
          attribute ledger_attribute: :name,
                    resource_attribute: :name

          attribute ledger_attribute: :externalid,
                    resource_attribute: :external_id

          attribute ledger_attribute: :symbol,
                    resource_attribute: :symbol

          attribute ledger_attribute: :exchangerate,
                    resource_attribute: :exchange_rate
        end
      end
    end
  end
end
