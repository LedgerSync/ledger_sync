# frozen_string_literal: true

require_relative 'invoice'

module LedgerSync
  module Bundles
    module ModernTreasury
      class PaymentLineItem < ModernTreasury::Resource
    attribute :amount, type: Type::Integer

    references_many :ledger_transactions, to: [Invoice]

    def name
      amount
    end
      end
    end
  end
end
