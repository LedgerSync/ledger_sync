# frozen_string_literal: true

#
# Parser for OpenAPI 3.0 data for a given record method
#
module LedgerSync
  module Ledgers
    module NetSuite
      class Record
        class Property < Util::ReadOnlyObject
          attribute :enum, default: nil
          attribute :format, default: nil
          attribute :key
          attribute :nullable, default: false
          attribute :read_only, default: false, source: :readOnly
          attribute :title
          attribute :type
        end
      end
    end
  end
end
