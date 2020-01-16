# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Mixins
      module OffsetAndLimitPaginationSearcherMixin
        def next_searcher
          paginate(limit: limit, offset: offset + limit)
        end

        def previous_searcher
          return nil if offset <= 1

          paginate(limit: limit, offset: offset - limit)
        end

        private

        def default_offset
          0
        end

        def default_limit
          10
        end

        def limit
          pagination.fetch(:limit, default_limit).to_i
        end

        def offset
          pagination.fetch(:offset, default_offset).to_i
        end
      end
    end
  end
end
