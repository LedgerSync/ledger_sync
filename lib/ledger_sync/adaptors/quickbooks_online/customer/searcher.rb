module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Customer
        class Searcher < LedgerSync::Adaptors::QuickBooksOnline::Searcher
          def query_string
            "DisplayName LIKE '%#{query}%'"
          end
        end
      end
    end
  end
end
