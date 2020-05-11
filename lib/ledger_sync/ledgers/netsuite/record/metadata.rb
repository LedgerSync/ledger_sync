# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Record
        #
        # Helper class for retrieving record metadata:
        # - available http_methods
        # - record properties/attributes
        #
        class Metadata
          BASE_PATH = 'metadata-catalog'

          attr_reader :client,
                      :record

          def initialize(client:, record:)
            @client = client
            @record = record
          end

          def create
            @create ||= http_methods.find { |e| e.key == "post /#{record}" }
          end

          def delete
            @delete ||= http_methods.find { |e| e.key == "delete /#{record}/{id}" }
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

          def index
            @index ||= http_methods.find { |e| e.key == "get /#{record}" }
          end

          def metadata_response
            @metadata_response = begin
              client.get(
                headers: {
                  'Accept' => 'application/swagger+json'
                },
                path: "#{BASE_PATH}?select=#{record}"
              )
            end
          end

          def properties
            @properties ||= begin
              ret = []
              props = metadata_response.body['components']['schemas'][record.to_s]['properties']
              props.map do |key, prop|
                next unless prop.key?('title')

                ret << Property.new_from_hash(
                  prop.merge(
                    key: key
                  )
                )
              end
              ret
            end
          end

          def patch
            @patch ||= http_methods.find { |e| e.key == "patch /#{record}/{id}" }
          end

          def show
            @show ||= http_methods.find { |e| e.key == "get /#{record}/{id}" }
          end

          def update
            @update ||= http_methods.find { |e| e.key == "patch /#{record}/{id}" }
          end

          def upsert
            @upsert ||= http_methods.find { |e| e.key == "put /#{record}/{id}" }
          end
        end
      end
    end
  end
end
