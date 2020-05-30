# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Check
        class Deserializer < NetSuite::Deserializer
          id

          attribute :memo

          attribute :trandate

          references_one :account

          references_one :currency

          references_one :department

          attribute :entity,
                    type: Type::DeserializerEntityType.new

          references_many :line_items,
                          hash_attribute: 'expense.items'
        end
      end
    end
  end
end
