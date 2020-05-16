# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'
require_relative 'department'
require_relative 'vendor'
require_relative 'bill_payment_line_item'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPayment < QuickBooksOnline::Resource
        PAYMENT_TYPES = {
          'cash' => 'Cash',
          'check' => 'Check',
          'credit_card' => 'CreditCard'
        }.freeze

        attribute :amount, type: Type::Integer
        attribute :memo, type: Type::String
        attribute :transaction_date, type: Type::Date
        attribute :exchange_rate, type: Type::Float
        attribute :reference_number, type: Type::String
        attribute :payment_type, type: Type::StringFromSet.new(values: PAYMENT_TYPES.keys)

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
  end
end
