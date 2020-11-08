# frozen_string_literal: true

require_relative 'account'
require_relative 'ledger_class'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class AccountBasedExpenseLineDetail < QuickBooksOnline::Resource
        references_one :Account, to: Account
        references_one :Class, to: LedgerClass

        def name
          "#{self.Account.try(:name)} - #{self.Class.try(:name)}"
        end
      end
    end
  end
end
