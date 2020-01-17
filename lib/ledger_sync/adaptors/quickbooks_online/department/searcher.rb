# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Department
        class Searcher < LedgerSync::Adaptors::QuickBooksOnline::Searcher
          private

          def query_string
            @query_string ||= "Name LIKE '%#{query}%'"
          end
        end
      end
    end
  end
end
