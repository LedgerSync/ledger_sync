# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CheckLineItem < NetSuite::Resource
        references_one :account
        references_one :ledger_class
        references_one :department
        attribute :amount, type: Type::Float
        attribute :memo, type: Type::String
      end
    end
  end
end
