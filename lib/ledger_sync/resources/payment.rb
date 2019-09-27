module LedgerSync
  class Payment < LedgerSync::Resource
    attribute :currency, type: :string
    reference :customer, to: Customer
    attribute :amount, type: :number

    def name
      "Payment: #{amount} #{currency}"
    end
  end
end
