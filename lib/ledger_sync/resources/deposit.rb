# frozen_string_literal: true

require_relative 'account'
require_relative 'department'
require_relative 'deposit_line_item'

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
