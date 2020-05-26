# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CustomerDeposit
        class Deserializer < NetSuite::Deserializer
          id

          attribute :account,
                    type: Type::DeserializerAccountType.new(account_class: Account)

          attribute :customer,
                    type: Type::DeserializerCustomerType.new(customer_class: Customer)

          attribute :payment
          attribute :undepFunds
        end
      end
    end
  end
end
