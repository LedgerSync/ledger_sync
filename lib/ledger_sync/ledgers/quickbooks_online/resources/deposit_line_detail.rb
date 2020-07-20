# frozen_string_literal: true

require_relative 'account'
require_relative 'customer'
require_relative 'ledger_class'
require_relative 'vendor'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DepositLineDetail < QuickBooksOnline::Resource
        references_one :Account, to: Account
        references_one :Class, to: LedgerClass
        references_one :Entity, to: [Customer, Vendor]

        def name
          "#{self.Account.try(:name)} - #{self.Class.try(:name)}"
        end
      end
    end
  end
end
