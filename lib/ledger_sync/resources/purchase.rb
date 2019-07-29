module LedgerSync
  class Purchase < LedgerSync::Resource
    attribute :currency
    reference :vendor, Vendor
    attribute :amount

    def name
      "Purchase: #{amount} #{currency}"
    end
  end
end
