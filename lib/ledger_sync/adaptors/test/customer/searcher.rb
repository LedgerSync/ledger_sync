module LedgerSync
  module Adaptors
    module Test
      module Customer
        class Searcher < LedgerSync::Adaptors::Searcher
          def next_searcher
            paginate(cursor: 'asdf')
          end

          def previous_searcher
            paginate(cursor: 'asdf')
          end

          def resources
            @resources ||= begin
              adaptor
                .query(
                  resource: 'customer',
                  query: "name LIKE '#{query}%'"
                )
                .map do |c|
                  LedgerSync::Customer.new(
                    ledger_id: c.fetch('id'),
                    name: c.dig('name'),
                    # active: c.dig('active')
                  )
                end
            end
          end

          def search
            super
          rescue OAuth2::Error => e
            failure(e)
          end
        end
      end
    end
  end
end
