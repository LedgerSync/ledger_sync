# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Searcher < Ledgers::Searcher
        include Mixins::OffsetAndLimitPaginationSearcherMixin

        def query_string
          ''
        end

        def resources
          resource_class = self.class.inferred_resource_class

          response = connection.query(
            limit: limit,
            offset: offset,
            query: query_string,
            resource_class: resource_class
          )
          return [] if response.body.blank?

          (response.body.dig(
            'QueryResponse',
            connection.class.ledger_resource_type_for(
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
        def default_offset
          1
        end
      end
    end
  end
end
