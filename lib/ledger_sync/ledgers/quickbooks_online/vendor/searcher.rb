# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Vendor
        class Searcher < Searcher
          def query_string
            "DisplayName LIKE '%#{query}%'"
          end
        end
      end
    end
  end
end
