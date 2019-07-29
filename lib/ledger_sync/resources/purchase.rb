module LedgerSync
  class Purchase < LedgerSync::Resource
    attribute :currency
    reference :vendor, Vendor
    attribute :amount
    attribute :memo
    attribute :payment_type
    attribute :transaction_date

    def name
      "Purchase: #{amount} #{currency}"
    end
  end
end
