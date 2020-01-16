# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class Searcher < Adaptors::Searcher
        include Mixins::OffsetAndLimitPaginationSearcherMixin

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
