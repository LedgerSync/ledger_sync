module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Customer
        class Searcher < LedgerSync::Ledgers::QuickBooksOnline::Searcher
          def query_string
            "DisplayName LIKE '%#{query}%'"
          end
        end
      end
    end
  end
end
