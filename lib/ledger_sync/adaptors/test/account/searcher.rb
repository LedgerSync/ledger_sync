module LedgerSync
  module Adaptors
    module Test
      module Account
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
                  resource: 'account',
                  query: "name LIKE '#{query}%'"
                )
                .map do |c|
                  LedgerSync::Account.new(
                    ledger_id: c.fetch('id'),
                    name: c.dig('name'),
                    account_type: c.dig('account_type')
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
