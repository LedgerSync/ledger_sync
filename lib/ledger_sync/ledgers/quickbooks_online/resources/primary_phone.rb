# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class PrimaryPhone < QuickBooksOnline::Resource
        attribute :FreeFormNumber, type: LedgerSync::Type::String
      end
    end
  end
end
