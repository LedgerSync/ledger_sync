# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'
require_relative 'customer'
require_relative 'invoice_sales_line_item'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Invoice < QuickBooksOnline::Resource
        attribute :memo, type: Type::String
        attribute :transaction_date, type: Type::Date
        attribute :deposit, type: Type::Integer

        references_one :customer, to: Customer
        references_one :account, to: Account
        references_one :currency, to: Currency

        references_many :line_items, to: InvoiceSalesLineItem

        def name
          "Invoice: #{transaction_date}"
        end
      end
    end
  end
end
