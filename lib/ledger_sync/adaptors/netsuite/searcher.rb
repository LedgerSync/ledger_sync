# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      class Searcher < Adaptors::Searcher
        include Mixins::OffsetAndLimitPaginationSearcherMixin
      end
    end
  end
end
