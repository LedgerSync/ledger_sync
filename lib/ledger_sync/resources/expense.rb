module LedgerSync
  class Expense < LedgerSync::Resource
    attribute :currency
    reference :vendor, Vendor
    attribute :amount
    attribute :memo
    attribute :payment_type
    attribute :transaction_date
    attribute :transactions

    def name
      "Purchase: #{amount} #{currency}"
    end
  end
end
