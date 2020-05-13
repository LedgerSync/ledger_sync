# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Item < QuickBooksOnline::Record
        attribute :name, type: Type::String
      end
    end
  end
end
