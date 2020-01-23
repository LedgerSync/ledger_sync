# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'
require_relative 'customer'
require_relative 'payment_line_item'

module LedgerSync
  class Payment < LedgerSync::Resource
    attribute :amount, type: Type::Integer
    attribute :memo, type: Type::String
    attribute :transaction_date, type: Type::Date
    attribute :exchange_rate, type: Type::Float
    attribute :reference_number, type: Type::String

    references_one :customer, to: Customer
    references_one :deposit_account, to: Account
    references_one :account, to: Account
    references_one :currency, to: Currency

    references_many :line_items, to: PaymentLineItem

    def name
      "Payment: #{amount} #{currency}"
    end
  end
end
