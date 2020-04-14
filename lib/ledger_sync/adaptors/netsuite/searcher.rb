# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      class Searcher < Adaptors::Searcher
        include Mixins::OffsetAndLimitPaginationSearcherMixin

        def resources
          resource_class = self.class.inferred_resource_class

          @resources ||= begin
            @request = adaptor
              .get(
                path: "/#{adaptor.class.ledger_resource_type_for(resource_class: resource_class)}?limit=#{limit}&offset=#{offset}"
              )

            unless request.body.key?('items')
              pd request.body
              byebug
            end

            request.body
              .fetch('items')
              .map do |c|
                ledger_deserializer_class.new(
                  resource: resource_class.new
                ).deserialize(hash: c)
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
