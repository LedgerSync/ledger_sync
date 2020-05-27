# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CheckLineItem < NetSuite::Resource
        references_one :account, to: Account
        references_one :ledger_class, to: LedgerClass
        references_one :department, to: Department
        attribute :amount, type: Type::Float
        attribute :memo, type: Type::String

        def name
          memo
        end
      end
    end
  end
end
