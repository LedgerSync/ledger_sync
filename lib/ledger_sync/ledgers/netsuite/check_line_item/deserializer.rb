# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CheckLineItem
        class Deserializer < NetSuite::Deserializer
          attribute :amount
          attribute :memo
          references_one :account
          references_one :ledger_class
          references_one :department
        end
      end
    end
  end
end
