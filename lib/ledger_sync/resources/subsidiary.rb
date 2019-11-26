# frozen_string_literal: true

module LedgerSync
  class Subsidiary < LedgerSync::Resource
    attribute :name, type: Type::String
    attribute :state, type: Type::String
  end
end
