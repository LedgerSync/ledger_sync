# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      class Searcher < Adaptors::Searcher
        include Mixins::OffsetAndLimitPaginationSearcherMixin

        def query_string
          ''
        end

        def ledger_searcher_deserializer_class
          @ledger_searcher_deserializer_class ||= self.class.inferred_searcher_ledger_deserializer_class
        end

        def resources
          resource_class = self.class.inferred_resource_class

          @resources ||= begin
            @request = adaptor
              .post(
                body: {"q": "#{query_string}"},
                request_url: adaptor.api_base_url.gsub("/record/v1", "") + "/query/v1/suiteql?limit=#{limit}&offset=#{offset}"
              )

            case request.status
            when 200
              request.body
                .fetch('items')
                .map do |c|
                  ledger_searcher_deserializer_class.new(
                    resource: resource_class.new
                  ).deserialize(hash: c)
                end
            when 404
              []
            end
          end
        end

        private

        def default_offset
          0
        end
      end
    end
  end
end
