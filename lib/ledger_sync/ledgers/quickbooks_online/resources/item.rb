# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Item < QuickBooksOnline::Resource
        attribute :name, type: Type::String
      end
    end
  end
end
