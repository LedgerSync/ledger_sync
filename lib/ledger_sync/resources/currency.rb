# frozen_string_literal: true

module LedgerSync
  class Currency < LedgerSync::Resource
    attribute :exchange_rate, type: Type::Float
    attribute :name, type: Type::String
    attribute :symbol, type: Type::String
  end
end
