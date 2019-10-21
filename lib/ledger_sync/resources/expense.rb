module LedgerSync
  class Expense < LedgerSync::Resource
    attribute :currency, type: Type::String
    attribute :memo, type: Type::String
    attribute :payment_type, type: Type::String
    attribute :transaction_date, type: Type::Date
    attribute :exchange_rate, type: Type::Float
    attribute :reference_number, type: Type::String

    references_one :vendor, to: Vendor
    references_one :account, to: Account

    references_many :line_items, to: ExpenseLineItem

    def amount
      line_items.map(&:amount).sum
    end

    def name
      "Purchase: #{amount} #{currency}"
    end
  end
end
