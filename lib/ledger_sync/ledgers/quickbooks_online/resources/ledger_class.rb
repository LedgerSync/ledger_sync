# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerClass < QuickBooksOnline::Resource
        attribute :Name, type: Type::String
        attribute :FullyQualifiedName, type: Type::String
        attribute :Active, type: Type::Boolean
        attribute :SubClass, type: Type::Boolean

        references_one :Parent, to: LedgerClass

        def name
          self.Name
        end
      end
    end
  end
end
