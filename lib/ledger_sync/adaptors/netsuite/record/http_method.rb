# frozen_string_literal: true

#
# Parser for OpenAPI 3.0 data for a given record method
#
module LedgerSync
  module Adaptors
    module NetSuite
      module Record
        class HTTPMethod
          attr_reader :method,
                      :parameters,
                      :path,
                      :raw,
                      :summary

          def initialize(method:, parameters:, path:, raw:, summary:)
            @method = method
            @parameters = parameters
            @path = path
            @raw = raw
            @summary = summary
          end

          def self.new_from_hash(data:, method:, path:)
            new(
              method: method,
              parameters: data['parameters'],
              path: path,
              raw: data,
              summary: data['summary']
            )
          end
        end
      end
    end
  end
end
