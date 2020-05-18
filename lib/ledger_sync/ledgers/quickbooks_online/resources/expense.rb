# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'
require_relative 'customer'
require_relative 'department'
require_relative 'expense_line_item'
require_relative 'vendor'
require_relative 'bill_payment'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense < QuickBooksOnline::Resource
        PAYMENT_TYPES = BillPayment::PAYMENT_TYPES

        attribute :memo, type: Type::String
        attribute :payment_type, type: Type::StringFromSet.new(values: PAYMENT_TYPES.keys)
        attribute :transaction_date, type: Type::Date
        attribute :exchange_rate, type: Type::Float
        attribute :reference_number, type: Type::String

        references_one :entity, to: [Customer, Vendor]
        references_one :account, to: Account
        references_one :department, to: Department
        references_one :currency, to: Currency

        references_many :line_items, to: ExpenseLineItem

        def amount
          line_items.map(&:amount).sum
        end

        def name
          "Purchase: #{amount} #{currency.try(:symbol)}"
        end
      end
    end
  end
end
