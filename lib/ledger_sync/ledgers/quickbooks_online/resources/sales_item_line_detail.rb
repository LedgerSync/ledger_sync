# frozen_string_literal: true

require_relative 'item'
require_relative 'ledger_class'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class SalesItemLineDetail < QuickBooksOnline::Resource
        references_one :Item, to: Item
        references_one :Class, to: LedgerClass

        def name
          "#{self.Item.try(:name)} #{self.Class.try(:name)}"
        end
      end
    end
  end
end
