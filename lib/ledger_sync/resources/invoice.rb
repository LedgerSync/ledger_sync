module LedgerSync
  class Invoice < LedgerSync::Resource
    attribute :customer
    attribute :number
    attribute :line_items
    attribute :currency

    def name
      "Invoice ##{number}"
    end
  end
end
