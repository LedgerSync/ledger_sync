# frozen_string_literal: true

require_relative 'account'
require_relative 'customer'
require_relative 'ledger_class'
require_relative 'vendor'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DepositLineItem < QuickBooksOnline::Record
        references_one :account, to: Account
        references_one :ledger_class, to: LedgerClass
        attribute :amount, type: Type::Integer
        attribute :description, type: Type::String

        references_one :entity, to: [Customer, Vendor]

        def name
          description
        end
      end
    end
  end
end
