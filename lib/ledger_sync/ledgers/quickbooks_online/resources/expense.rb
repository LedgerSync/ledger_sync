# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'
require_relative 'customer'
require_relative 'department'
require_relative 'expense_line'
require_relative 'vendor'
require_relative 'bill_payment'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense < QuickBooksOnline::Resource
        PAYMENT_TYPES = BillPayment::PAYMENT_TYPES

        attribute :PrivateNote, type: Type::String
        attribute :PaymentType, type: Type::StringFromSet.new(values: PAYMENT_TYPES.keys)
        attribute :TxnDate, type: Type::Date
        attribute :ExchangeRate, type: Type::Float
        attribute :DocNumber, type: Type::String

        references_one :Entity, to: [Customer, Vendor]
        references_one :Account, to: Account
        references_one :Department, to: Department
        references_one :Currency, to: Currency

        references_many :Line, to: ExpenseLine

        def amount
          line_items.inject(0) { |sum, li| sum + li.Amount }
        end

        def name
          "Purchase: #{amount} #{self.Currency.try(:symbol)}"
        end
      end
    end
  end
end
