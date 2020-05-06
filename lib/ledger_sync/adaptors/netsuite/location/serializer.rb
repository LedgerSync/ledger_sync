# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Location
        class Serializer < NetSuite::Serializer
          attribute :name
        end
      end
    end
  end
end
