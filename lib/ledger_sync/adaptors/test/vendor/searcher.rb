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
                .map do |v|
                  LedgerSync::Vendor.new(
                    ledger_id: v.fetch('id'),
                    first_name: v.fetch('first_name', ''),
                    last_name:  v.fetch('last_name', '')
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
