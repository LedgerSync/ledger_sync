# frozen_string_literal: true

module LedgerSync
  class PaymentLineItem < LedgerSync::Resource
    attribute :amount, type: Type::Integer

    references_many :linked_txns, to: Txn

    def name
      amount
    end
  end
end
