module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerClass
        class Searcher < LedgerSync::Adaptors::QuickBooksOnline::Searcher
          def resources
            @resources ||= begin
              adaptor
                .query(
                  resource: 'class',
                  query: "Name LIKE '%#{query}%'",
                  limit: limit,
                  offset: offset
                )
                .map do |c|
                  LedgerSync::LedgerClass.new(
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
