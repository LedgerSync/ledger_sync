# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'
require_relative 'customer'
require_relative 'payment_line'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Payment < QuickBooksOnline::Resource
        attribute :TotalAmt, type: Type::Integer
        attribute :PrivateNote, type: Type::String
        attribute :TxnDate, type: Type::Date
        attribute :ExchangeRate, type: Type::Float
        attribute :PaymentRefNum, type: Type::String

        references_one :Customer, to: Customer
        references_one :DepositToAccount, to: Account
        references_one :ARAccount, to: Account
        references_one :Currency, to: Currency

        references_many :Line, to: PaymentLine

        def name
          "Payment: #{amount} #{currency}"
        end
      end
    end
  end
end
