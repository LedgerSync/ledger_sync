# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Searcher < Ledgers::Searcher
        include Mixins::OffsetAndLimitPaginationSearcherMixin

        def query_attributes
          @query_attributes ||= searcher_deserializer_class.attributes.values.map(&:hash_attribute)
        end

        def query_string
          "SELECT #{query_attributes.join(', ')} FROM #{query_table}"
        end

        def query_table
          @query_table ||= client.class.ledger_resource_type_for(resource_class: self.class.inferred_resource_class)
        end

        def request_url
          client.api_base_url.gsub('/record/v1', '') + "/query/v1/suiteql?limit=#{limit}&offset=#{offset}"
        end

        def resources
          resource_class = self.class.inferred_resource_class

          @resources ||= begin
            @request = client
                       .post(
                         body: { q: query_string.to_s },
                         request_url: request_url
                       )

            case request.status
            when 200
              request.body
                     .fetch('items')
                     .map do |c|
                searcher_deserializer_class.new.deserialize(hash: c, resource: resource_class.new)
              end
            when 404
              []
            when 400
              if request.body['title'].include?(
                'Invalid search query Search error occurred: Record ‘subsidiary’ was not found'
              )
                raise LedgerSync::Ledgers::NetSuite::Error::SubsidiariesNotEnabled
              end
            end
          end
        end

        def searcher_deserializer_class
          @searcher_deserializer_class ||= self.class.inferred_serialization_class(type: 'SearcherDeserializer')
        end

        private

        def default_offset
          0
        end
      end
    end
  end
end
