module LedgerSync
  class Payment < LedgerSync::Resource
    attribute :currency
    reference :customer, Customer
    attribute :amount

    def name
      "Payment: #{amount} #{currency}"
    end
  end
end
