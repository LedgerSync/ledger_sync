# frozen_string_literal: true

require_relative 'account'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class CreditCardPayment < QuickBooksOnline::Resource
        references_one :CCAccount, to: Account
      end
    end
  end
end
