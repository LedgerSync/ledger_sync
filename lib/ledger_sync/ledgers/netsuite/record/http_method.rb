# frozen_string_literal: true

#
# Parser for OpenAPI 3.0 data for a given record method
#
module LedgerSync
  module Ledgers
    module NetSuite
      class Record
        class HTTPMethod < Util::ReadOnlyObject
          attribute :key
          attribute :method
          attribute :path
          attribute :summary

          def initialize(args = {})
            super(
              args.merge(
                key: "#{args.fetch(:method)} #{args.fetch(:path)}".downcase
              )
            )
          end

          def parameters
            Parameter.new_from_array(
              raw[:parameters]
            )
          end
        end
      end
    end
  end
end
