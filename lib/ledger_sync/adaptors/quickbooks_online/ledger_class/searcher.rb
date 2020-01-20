# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerClass
        class Searcher < LedgerSync::Adaptors::QuickBooksOnline::Searcher
          def query_string
            "Name LIKE '%#{query}%'"
          end
        end
      end
    end
  end
end
