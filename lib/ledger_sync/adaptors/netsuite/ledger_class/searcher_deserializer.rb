# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module LedgerClass
        class SearcherDeserializer < NetSuite::Deserializer
          id

          attribute :name

          attribute :active,
                    ledger_attribute: :isinactive,
                    type: Type::Deserializer::Active.new
        end
      end
    end
  end
end
