# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class CheckPayment < QuickBooksOnline::Resource
        references_one :BankAccount, to: Account
      end
    end
  end
end
