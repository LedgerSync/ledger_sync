module LedgerSync
  class Deposit < LedgerSync::Resource
    attribute :currency, type: Type::String
    attribute :memo, type: Type::String
    attribute :transaction_date, type: Type::Date
    attribute :exchange_rate, type: Type::Float

    references_one :to_account, to: Account

    references_many :line_items, to: DepositLineItem

    def name
      "Deposit: #{currency}"
    end
  end
end
