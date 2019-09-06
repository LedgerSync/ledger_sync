module LedgerSync
  module Adaptors
    module Test
      module Vendor
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
                  resource: 'vendor',
                  query: "name LIKE '#{query}%'"
                )
                .map do |c|
                  first, *rest = c.dig('name').split(/, /)
                  LedgerSync::Vendor.new(
                    ledger_id: c.fetch('id'),
                    first_name: first,
                    last_name: rest.join(' '),
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
