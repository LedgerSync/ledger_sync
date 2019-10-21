module LedgerSync
  class Bill < LedgerSync::Resource
    attribute :currency, type: Type::String
    attribute :memo, type: Type::String
    attribute :transaction_date, type: Type::Date
    attribute :due_date, type: Type::Date
    attribute :reference_number, type: Type::String

    references_one :vendor, to: Vendor
    references_one :account, to: Account

    references_many :line_items, to: BillLineItem

    def name
      "Bill: #{transaction_date.to_s}"
    end
  end
end
