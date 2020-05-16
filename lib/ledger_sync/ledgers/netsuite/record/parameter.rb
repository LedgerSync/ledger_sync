# frozen_string_literal: true

#
# Parser for OpenAPI 3.0 data for a given record method
#
module LedgerSync
  module Ledgers
    module NetSuite
      class Record
        class Parameter < Util::ReadOnlyObject
          attribute :description
          attribute :location, source: :in
          attribute :name
          attribute :required
          attribute :schema
        end
      end
    end
  end
end
