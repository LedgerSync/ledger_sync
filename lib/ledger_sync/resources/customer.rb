# frozen_string_literal: true

module LedgerSync
  class Customer < LedgerSync::Resource
    attribute :email, type: Type::String
    attribute :name, type: Type::String
    attribute :phone_number, type: Type::String
  end
end
