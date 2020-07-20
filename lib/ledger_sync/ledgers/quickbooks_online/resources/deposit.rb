# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'
require_relative 'department'
require_relative 'deposit_line'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Deposit < QuickBooksOnline::Resource
        attribute :PrivateNote, type: Type::String
        attribute :TxnDate, type: Type::Date
        attribute :ExchangeRate, type: Type::Float

        references_one :DepositToAccount, to: Account
        references_one :Department, to: Department
        references_one :Currency, to: Currency

        references_many :Line, to: DepositLine

        def name
          "Deposit: #{self.Currency.try(:symbol)}"
        end
      end
    end
  end
end
