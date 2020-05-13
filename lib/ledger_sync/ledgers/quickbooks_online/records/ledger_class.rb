# frozen_string_literal: true

require_relative 'ledger_class'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerClass < QuickBooksOnline::Record
        attribute :name, type: Type::String
        attribute :fully_qualified_name, type: Type::String
        attribute :active, type: Type::Boolean
        attribute :sub_class, type: Type::Boolean

        references_one :parent, to: LedgerClass
      end
    end
  end
end
