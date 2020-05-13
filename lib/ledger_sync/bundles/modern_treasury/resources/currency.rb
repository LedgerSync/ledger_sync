# frozen_string_literal: true

module LedgerSync
  module Bundles
    module ModernTreasury
      class Currency < ModernTreasury::Resource
        attribute :exchange_rate, type: Type::Float
        attribute :name, type: Type::String
        attribute :symbol, type: Type::String
      end
    end
  end
end
