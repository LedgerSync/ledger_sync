# frozen_string_literal: true

require_relative 'currency'

module LedgerSync
  module Bundles
    module ModernTreasury
      class Account < ModernTreasury::Resource
    attribute :name, type: Type::String
    attribute :classification, type: Type::String
    attribute :account_type, type: Type::String
    attribute :account_sub_type, type: Type::String
    attribute :number, type: Type::String
    attribute :description, type: Type::String
    attribute :active, type: Type::Boolean

    references_one :currency, to: Currency
      end
    end
  end
end
