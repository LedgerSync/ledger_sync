# frozen_string_literal: true

require_relative 'account'

module LedgerSync
  class Transfer < LedgerSync::Resource
    attribute :currency, type: Type::String
    attribute :amount, type: Type::Integer
    attribute :memo, type: Type::String
    attribute :transaction_date, type: Type::Date

    references_one :from_account, to: Account
    references_one :to_account, to: Account

    def name
      "Transaction: #{amount} #{currency}"
    end
  end
end
