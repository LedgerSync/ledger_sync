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

          references_one :account,
                         deserializer: Account::Deserializer

          references_one :ledger_class,
                         deserializer: LedgerClass::Deserializer

          references_one :department,
                         deserializer: Department::Deserializer
        end
      end
    end
  end
end
