# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CustomerDeposit
        class Deserializer < NetSuite::Deserializer
          id

          references_one :account

          references_one :customer

          attribute :payment
          attribute :undepFunds
        end
      end
    end
  end
end
