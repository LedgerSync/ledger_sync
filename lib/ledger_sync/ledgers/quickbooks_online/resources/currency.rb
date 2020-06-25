# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Currency < QuickBooksOnline::Resource
        attribute :ExchangeRate, type: Type::Float
        attribute :Name, type: Type::String
        attribute :Symbol, type: Type::String

        def ledger_id
          self.Symbol
        end
      end
    end
  end
end
