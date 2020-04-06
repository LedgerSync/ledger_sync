# frozen_string_literal: true

module LedgerSync
  module Adaptors
    class Searcher
      include SimplySerializable::Mixin
      include Mixins::InferResourceClassMixin
      include Mixins::InferLedgerSerializerMixin

      attr_reader :adaptor,
                  :query,
                  :pagination,
                  :request

      serialize only: %i[
        adaptor
        query
        pagination
        resources
      ]

      def initialize(args = {})
        @adaptor    = args.fetch(:adaptor)
        @query      = args.fetch(:query)
        @pagination = args.fetch(:pagination, {})
      end

      def ledger_deserializer_class
        @ledger_deserializer_class ||= self.class.inferred_ledger_deserializer_class
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
