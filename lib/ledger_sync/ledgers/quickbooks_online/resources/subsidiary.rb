# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Subsidiary < QuickBooksOnline::Resource
        attribute :Name, type: LedgerSync::Type::String
        attribute :State, type: LedgerSync::Type::String

        def name
          self.Name
        end
      end
    end
  end
end
