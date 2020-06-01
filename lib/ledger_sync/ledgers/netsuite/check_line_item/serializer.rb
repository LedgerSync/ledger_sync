# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module NetSuite
      class CheckLineItem
        class Serializer < NetSuite::Serializer
          attribute :amount
          attribute :memo

          references_one :account,
                         serializer: Reference::Serializer

          references_one :department,
                         serializer: Reference::Serializer

          references_one :ledger_class,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end
