module LedgerSync
  class Expense < LedgerSync::Resource
    attribute :currency, type: :string
    reference :vendor, Vendor
    attribute :amount, type: :integer
    attribute :memo, type: :string
    attribute :payment_type, type: :string
    attribute :transaction_date, type: :date
    attribute :transactions

    def name
      "Purchase: #{amount} #{currency}"
    end
  end
end
