# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Currency
        class Serializer < NetSuite::Serializer
          id

          attribute :name

          attribute :externalid,
                    resource_attribute: :external_id

          attribute :symbol

          attribute :exchangerate,
                    resource_attribute: :exchange_rate
        end
      end
    end
  end
end
