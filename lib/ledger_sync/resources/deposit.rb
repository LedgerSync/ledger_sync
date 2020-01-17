# frozen_string_literal: true

require_relative 'account'
require_relative 'bill_line_item'
require_relative 'department'

module LedgerSync
  class Deposit < LedgerSync::Resource
    attribute :currency, type: Type::String
    attribute :memo, type: Type::String
    attribute :transaction_date, type: Type::Date
    attribute :exchange_rate, type: Type::Float

    references_one :account, to: Account
    references_one :department, to: Department

    references_many :line_items, to: DepositLineItem

    def name
      "Deposit: #{currency}"
    end
  end
end
