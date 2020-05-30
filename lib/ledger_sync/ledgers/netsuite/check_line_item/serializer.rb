# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CheckLineItem
        class Serializer < NetSuite::Serializer
          attribute :amount
          attribute :memo

          references_one :account
          references_one :department
          references_one :ledger_class
        end
      end
    end
  end
end
