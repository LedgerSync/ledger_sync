require 'ledger_sync/adaptors/quickbooks_online/account/mapping'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        class Searcher < LedgerSync::Adaptors::Searcher
          def next_searcher
            paginate(limit: limit, offset: offset + limit)
          end

          def previous_searcher
            return nil if offset <= 1

            paginate(limit: limit, offset: offset - limit)
          end

          def resources
            @resources ||= begin
              adaptor
                .query(
                  resource: 'account',
                  query: "Name LIKE '%#{query}%'",
                  limit: limit,
                  offset: offset
                )
                .map do |c|
                  LedgerSync::Account.new(
                    ledger_id: c.fetch('Id'),
                    name: c.fetch('Name'),
                    account_type: Mapping::ACCOUNT_TYPES.invert[c.fetch('AccountType')],
                    account_sub_type: Mapping::ACCOUNT_SUB_TYPES.invert[c.fetch('AccountSubType')]
                  )
                end
            end
          end

          def search
            super
          rescue OAuth2::Error => e
            @response = e # TODO: Better catch/raise errors as LedgerSync::Error
            failure
          end

          private
          # Pagination uses notation of limit and offset
          # limit: number of results per page
          #
          # offset: position of first result in a list.
          # starts from 1, not 0
          #
          # More here:
          # https://developer.intuit.com/app/developer/qbo/docs/develop/explore-the-quickbooks-online-api/data-queries#pagination

          def limit
            pagination.fetch(:limit, 10).to_i
          end

          def offset
            pagination.fetch(:offset, 1).to_i
          end
        end
      end
    end
  end
end
