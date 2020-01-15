# frozen_string_literal: true

module LedgerSync
  class PaymentLineItem < LedgerSync::Resource
    attribute :amount, type: Type::Integer

    references_many :ledger_transactions, to: [Invoice]

    def name
      amount
    end
  end
end