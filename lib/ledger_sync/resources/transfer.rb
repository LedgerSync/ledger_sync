# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'

module LedgerSync
  class Transfer < LedgerSync::Resource
    attribute :amount, type: Type::Integer
    attribute :memo, type: Type::String
    attribute :transaction_date, type: Type::Date

    references_one :from_account, to: Account
    references_one :to_account, to: Account
    references_one :currency, to: Currency

    def name
      "Transaction: #{amount} #{currency}"
    end
  end
end
