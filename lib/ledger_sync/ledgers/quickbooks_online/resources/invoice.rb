# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'
require_relative 'customer'
require_relative 'invoice_line'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Invoice < QuickBooksOnline::Resource
        attribute :PrivateNote, type: Type::String
        attribute :TxnDate, type: Type::Date
        attribute :Deposit, type: Type::Integer

        references_one :Customer, to: Customer
        references_one :DepositToAccount, to: Account
        references_one :Currency, to: Currency

        references_many :Line, to: InvoiceLine

        def name
          "Invoice: #{transaction_date}"
        end
      end
    end
  end
end
