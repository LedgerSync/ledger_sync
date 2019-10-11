# frozen_string_literal: true

module LedgerSync
  module Adaptors
    class Searcher
      include SimplySerializable::Mixin

      attr_reader :adaptor,
                  :query,
                  :pagination,
                  :resources

      serialize only: %i[
        adaptor
        query
        pagination
        resources
      ]

      def initialize(adaptor:, query:, pagination: {})
        @adaptor = adaptor
        @query = query
        @pagination = pagination
      end

      def next_searcher
        raise NotImplementedError
      end

      def previous_searcher
        raise NotImplementedError
      end

      def resources
        raise NotImplementedError
      end

      def search
        @search ||= success
      end

      private

      def paginate(**keywords)
        self.class.new(
          adaptor: adaptor,
          query: query,
          pagination: keywords
        )
      end

      def success
        SearchResult.Success(
          searcher: self
        )
      end

      def failure(searcher: nil, **keywords)
        SearchResult.Failure(
          searcher: searcher || self,
          **keywords
        )
      end
    end
  end
end
