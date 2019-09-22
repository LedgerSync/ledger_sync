module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Customer
        class Searcher < LedgerSync::Adaptors::QuickBooksOnline::Searcher
          def resources
            @resources ||= begin
              adaptor
                .query(
                  resource: 'customer',
                  query: "DisplayName LIKE '%#{query}%'",
                  limit: limit,
                  offset: offset
                )
                .map do |c|
                  LedgerSync::Customer.new(
                    ledger_id: c.fetch('Id'),
                    name: c.dig('FullyQualifiedName')
                  )
                end
            end
          end
        end
      end
    end
  end
end
