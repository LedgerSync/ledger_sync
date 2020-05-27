
# frozen_string_literal: true

require_relative '../account/deserializer'
require_relative '../department/deserializer'
require_relative '../ledger_class/deserializer'

module LedgerSync
  module Ledgers
    module NetSuite
      class CheckLineItem
        class Deserializer < NetSuite::Deserializer
          attribute :amount
          attribute :memo

          attribute :account,
                    type: Type::DeserializerAccountType.new(account_class: Account)

          attribute :ledger_class,
                    type: Type::DeserializerLedgerClassType.new(ledger_class: LedgerClass)

          attribute :department,
                    type: Type::DeserializerDepartmentType.new(department_class: Account)

        end
      end
    end
  end
end
