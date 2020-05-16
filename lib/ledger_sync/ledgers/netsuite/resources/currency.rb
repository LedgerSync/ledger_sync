# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Currency < NetSuite::Resource
        attribute :exchange_rate, type: Type::Float
        attribute :name, type: Type::String
        attribute :symbol, type: Type::String
      end
    end
  end
end
