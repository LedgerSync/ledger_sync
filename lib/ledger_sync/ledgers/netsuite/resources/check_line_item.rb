# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CheckLineItem < NetSuite::Resource
        references_one :account, to: NetSuite::Account
        references_one :ledger_class, to: NetSuite::LedgerClass
        references_one :department, to: NetSuite::Department
        attribute :amount, type: Type::Float
        attribute :memo, type: Type::String
      end
    end
  end
end
