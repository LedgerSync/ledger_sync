# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CustomerDeposit < NetSuite::Resource
        attribute :payment, type: Type::Float
        attribute :undepFunds, type: Type::Boolean

        references_one :account, to: Account
        references_one :customer, to: Customer
      end
    end
  end
end
