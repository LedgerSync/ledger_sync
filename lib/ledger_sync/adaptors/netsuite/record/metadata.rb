# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Record
        #
        # Helper class for retrieving record metadata:
        # - available http_methods
        # - record properties/attributes
        #
        class Metadata
          BASE_PATH = 'metadata-catalog'

          attr_reader :adaptor,
                      :record

          def initialize(adaptor:, record:)
            @adaptor = adaptor
            @record = record
          end

          def create
            @create ||= http_methods.find { |_e| "post /#{record}" }
          end

          def delete
            @delete ||= http_methods.find { |_e| "delete /#{record}/{id}" }
          end

          def find
            @find ||= show
          end

          def http_methods
            @http_methods ||= begin
              ret = []

              metadata_response.body['paths'].each do |path, path_data|
                path_data.each do |method, method_data|
                  ret << HTTPMethod.new_from_hash(
                    method_data.merge(
                      method: method,
                      path: path
                    )
                  )
                end
              end

              ret
            end
          end

          def metadata_response
            @metadata_response = begin
              adaptor.get(
                headers: {
                  'Accept' => 'application/swagger+json'
                },
                path: "#{BASE_PATH}?select=#{record}"
              )
            end
          end

          def properties
            @properties ||= Property.new_from_array(
              metadata_response['components']['schemas'][record.to_s]
            )
          end

          def index
            @index ||= http_methods.find { |_e| "get /#{record}" }
          end

          def show
            @show ||= http_methods.find { |_e| "get /#{record}/{id}" }
          end

          def update
            @update ||= http_methods.find { |_e| "patch /#{record}/{id}" }
          end

          def upsert
            @upsert ||= http_methods.find { |_e| "put /#{record}/{id}" }
          end
        end
      end
    end
  end
end
