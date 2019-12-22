# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Record
        class Metadata
          BASE_PATH = 'metadata-catalog/record'

          attr_reader :adaptor,
                      :record

          def initialize(adaptor:, record:)
            @adaptor = adaptor
            @record = record
          end

          def http_methods
            @http_methods ||= begin
              ret = []

              http_methods_response.body['paths'].each do |path, path_data|
                path_data.each do |method, method_data|
                  ret << HTTPMethod.new_from_hash(
                    data: method_data,
                    method: method,
                    path: path
                  )
                end
              end

              ret
            end
          end

          def http_methods_response
            @http_methods_response = begin
              adaptor.get(
                headers: {
                  'Accept' => 'application/swagger+json'
                },
                path: "#{BASE_PATH}?select=#{record}"
              )
            end
          end

          def properties
            @properties = properties_response.body['properties'].map do |key, data|
              Property.new_from_hash(
                data: data,
                key: key
              )
            end
          end

          def properties_response
            @properties_response = begin
              adaptor.get(
                headers: {
                  'Accept' => 'application/swagger+json'
                },
                path: "#{BASE_PATH}/#{record}"
              )
            end
          end
        end
      end
    end
  end
end
