# frozen_string_literal: true

require_relative 'account'

module LedgerSync
  class BillLineItem < LedgerSync::Resource
    references_one :account, to: Account
    references_one :ledger_class, to: LedgerClass
    attribute :amount, type: Type::Integer
    attribute :description, type: Type::String

    def name
      description
    end
  end
end
