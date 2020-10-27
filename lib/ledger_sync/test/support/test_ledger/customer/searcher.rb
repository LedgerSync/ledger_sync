# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module TestLedger
      class Customer
        class Searcher < LedgerSync::Ledgers::TestLedger::Searcher
          def query_string
            "DisplayName LIKE '%#{query}%'"
          end
        end
      end
    end
  end
end
