# frozen_string_literal: true

module LedgerSync
  class Account < LedgerSync::Resource
    attribute :name, type: Type::String
    attribute :classification, type: Type::String
    attribute :account_type, type: Type::String
    attribute :account_sub_type, type: Type::String
    attribute :number, type: Type::String
    attribute :currency, type: Type::String
    attribute :description, type: Type::String
    attribute :active, type: Type::Boolean
  end
end
