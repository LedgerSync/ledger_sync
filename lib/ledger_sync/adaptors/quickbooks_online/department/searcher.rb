module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Department
        class Searcher < LedgerSync::Adaptors::QuickBooksOnline::Searcher
          def resources
            @resources ||= begin
              adaptor
                .query(
                  resource: 'department',
                  query: "Name LIKE '%#{query}%'",
                  limit: limit,
                  offset: offset
                )
                .map do |c|
                  LedgerSync::Department.new(
                    ledger_id: c.fetch('Id'),
                    name: c.dig('Name')
                  )
                end
            end
          end
        end
      end
    end
  end
end
