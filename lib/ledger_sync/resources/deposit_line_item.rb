# frozen_string_literal: true

require_relative 'account'
require_relative 'customer'
require_relative 'vendor'

module LedgerSync
  class DepositLineItem < LedgerSync::Resource
    references_one :account, to: Account
    attribute :amount, type: Type::Integer
    attribute :description, type: Type::String

    references_one :entity, to: [Customer, Vendor]

    def name
      description
    end
  end
end
