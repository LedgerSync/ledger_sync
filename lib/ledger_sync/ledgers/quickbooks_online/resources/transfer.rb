# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Transfer < QuickBooksOnline::Resource
        attribute :Amount, type: Type::Integer
        attribute :PrivateNote, type: Type::String
        attribute :TxnDate, type: Type::Date

        references_one :FromAccount, to: Account
        references_one :ToAccount, to: Account
        references_one :Currency, to: Currency

        def name
          "Transfer: #{self.Amount} #{self.Currency}"
        end
      end
    end
  end
end
