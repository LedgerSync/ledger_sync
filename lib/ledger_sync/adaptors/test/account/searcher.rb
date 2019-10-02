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
                .map do |a|
                  LedgerSync::Account.new(
                    ledger_id: a.fetch('id'),
                    name: a.fetch('name', ''),
                    account_type: a.fetch('account_type', '')
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
