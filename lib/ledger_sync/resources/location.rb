# frozen_string_literal: true

module LedgerSync
  class Location < LedgerSync::Resource
    attribute :name, type: Type::String
  end
end
