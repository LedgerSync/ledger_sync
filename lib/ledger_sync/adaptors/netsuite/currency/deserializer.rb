# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Currency
        class Deserializer < NetSuite::Deserializer
          id

          attribute :name

          attribute :external_id,
                    hash_attribute: :externalid

          attribute :symbol

          attribute :exchange_rate,
                    hash_attribute: :exchangerate
        end
      end
    end
  end
end