# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      module Department
        class SearcherDeserializer < NetSuite::Deserializer
          id

          attribute :name

          attribute :active,
                    hash_attribute: :isinactive,
                    type: Type::Deserializer::Active.new
        end
      end
    end
  end
end