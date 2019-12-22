# frozen_string_literal: true

#
# Parser for OpenAPI 3.0 data for a given record method
#
module LedgerSync
  module Adaptors
    module NetSuite
      module Record
        class Property
          attr_reader :enum,
                      :format,
                      :key,
                      :title,
                      :type

          def initialize(
            enum: [],
            format: nil,
            key:,
            title:,
            type:
          )

            @enum = enum
            @format = format
            @key = key
            @title = title
            @type = type
          end

          def self.new_from_hash(data:, key:)
            new(
              enum: data['enum'],
              format: data['format'],
              key: key,
              title: data['title'],
              type: data['type']
            )
          end
        end
      end
    end
  end
end
