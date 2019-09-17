# frozen_string_literal: true

module LedgerSync
  class Payment < LedgerSync::Resource
    attribute :amount, type: Type::Integer
    attribute :currency, type: Type::String
    references_one :customer, to: Customer

    def name
      "Payment: #{amount} #{currency}"
    end
  end
end
