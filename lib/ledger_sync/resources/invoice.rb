module LedgerSync
  class Invoice < LedgerSync::Resource
    attribute :currency, type: Type::String
    attribute :memo, type: Type::String
    attribute :transaction_date, type: Type::Date
    attribute :deposit, type: Type::Integer

    references_one :customer, to: Customer
    references_one :account, to: Account

    references_many :line_items, to: InvoiceSalesLineItem

    def name
      "Invoice: #{transaction_date.to_s}"
    end
  end
end
