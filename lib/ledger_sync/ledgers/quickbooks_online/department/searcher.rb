# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Department
        class Searcher < LedgerSync::Ledgers::QuickBooksOnline::Searcher
          private

          def query_string
            @query_string ||= "Name LIKE '%#{query}%'"
          end
        end
      end
    end
  end
end
