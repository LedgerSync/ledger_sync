# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Currency
        class Serializer < NetSuite::Serializer
          attribute :name

          attribute :external_id,
                    ledger_attribute: :externalid

          attribute :symbol

          attribute :exchange_rate,
                    ledger_attribute: :exchangerate
        end
      end
    end
  end
end
