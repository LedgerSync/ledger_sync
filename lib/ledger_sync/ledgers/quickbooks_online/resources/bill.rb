# frozen_string_literal: true

require_relative 'account'
require_relative 'bill_line'
require_relative 'currency'
require_relative 'department'
require_relative 'vendor'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Bill < QuickBooksOnline::Resource
        attribute :PrivateNote, type: Type::String
        attribute :TxnDate, type: Type::Date
        attribute :DueDate, type: Type::Date
        attribute :DocNumber, type: Type::String

        references_one :Vendor, to: Vendor
        references_one :APAccount, to: Account
        references_one :Department, to: Department
        references_one :Currency, to: Currency

        references_many :Line, to: BillLine

        def name
          "Bill: #{self.TxnDate}"
        end
      end
    end
  end
end
