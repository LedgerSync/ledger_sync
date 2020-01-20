# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class Searcher < Adaptors::Searcher
        def next_searcher
          paginate(limit: limit, offset: offset + limit)
        end

        def previous_searcher
          return nil if offset <= 1

          paginate(limit: limit, offset: offset - limit)
        end

        def query_string
          ''
        end

        def resources
          resource_class = self.class.inferred_resource_class

          response = adaptor.query(
            limit: limit,
            offset: offset,
            query: query_string,
            resource_class: resource_class
          )
          return [] if response.body.blank?

          (response.body.dig(
            'QueryResponse',
            adaptor.class.ledger_resource_type_for(
              resource_class: resource_class
            ).classify
          ) || []).map do |c|
            self.class.inferred_ledger_serializer_class.new(
              resource: resource_class.new
            ).deserialize(
              hash: c
            )
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
