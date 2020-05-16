# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class PrimaryEmailAddr < QuickBooksOnline::Resource
        attribute :Address, type: LedgerSync::Type::String
      end
    end
  end
end
