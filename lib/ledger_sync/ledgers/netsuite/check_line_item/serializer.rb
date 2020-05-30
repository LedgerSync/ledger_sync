# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class CheckLineItem
        class Serializer < NetSuite::Serializer
          attribute :amount
          attribute :memo

          ledger_reference :account
          ledger_reference :department
          ledger_reference :ledger_class
        end
      end
    end
  end
end
