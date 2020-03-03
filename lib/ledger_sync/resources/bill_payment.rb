# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'
require_relative 'department'
require_relative 'vendor'
require_relative 'bill_payment_line_item'

module LedgerSync
  class BillPayment < LedgerSync::Resource
    attribute :amount, type: Type::Integer
    attribute :memo, type: Type::String
    attribute :transaction_date, type: Type::Date
    attribute :exchange_rate, type: Type::Float
    attribute :reference_number, type: Type::String
    attribute :payment_type, type: Type::String

    references_one :account, to: Account
    references_one :currency, to: Currency
    references_one :department, to: Department
    references_one :vendor, to: Vendor

    references_one :bank_account, to: Account
    references_one :credit_card_account, to: Account

    references_many :line_items, to: BillPaymentLineItem

    def name
      "Bill Payment: #{reference_number}"
    end
  end
end
