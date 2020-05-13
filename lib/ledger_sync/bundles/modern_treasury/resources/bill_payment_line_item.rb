# frozen_string_literal: true

require_relative 'bill'

module LedgerSync
  module Bundles
    module ModernTreasury
      class BillPaymentLineItem < ModernTreasury::Resource
    attribute :amount, type: Type::Integer

    references_many :ledger_transactions, to: [Bill]

    def name
      amount
    end
      end
    end
  end
end
