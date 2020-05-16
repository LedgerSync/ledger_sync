# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerClass
        class Searcher < LedgerSync::Ledgers::QuickBooksOnline::Searcher
          def query_string
            "Name LIKE '%#{query}%'"
          end
        end
      end
    end
  end
end
