# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'
require_relative 'department'
require_relative 'vendor'
require_relative 'bill_payment_line'
require_relative 'check_payment'
require_relative 'credit_card_payment'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPayment < QuickBooksOnline::Resource
        PAYMENT_TYPES = {
          'cash' => 'Cash',
          'check' => 'Check',
          'credit_card' => 'CreditCard'
        }.freeze

        attribute :TotalAmt, type: Type::Integer
        attribute :PrivateNote, type: Type::String
        attribute :TxnDate, type: Type::Date
        attribute :ExchangeRate, type: Type::Float
        attribute :DocNumber, type: Type::String
        attribute :PayType, type: Type::StringFromSet.new(values: PAYMENT_TYPES.keys)

        references_one :APAccount, to: Account
        references_one :Currency, to: Currency
        references_one :Department, to: Department
        references_one :Vendor, to: Vendor

        references_one :CheckPayment, to: CheckPayment
        references_one :CreditCardPayment, to: CreditCardPayment

        references_many :Line, to: BillPaymentLine

        def name
          "Bill Payment: #{self.DocNumber}"
        end
      end
    end
  end
end
