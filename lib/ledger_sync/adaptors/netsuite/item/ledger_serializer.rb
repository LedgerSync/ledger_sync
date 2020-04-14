# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Item
        class LedgerSerializer < NetSuite::LedgerSerializer
          id

          api_resource_type :items
        end
      end
    end
  end
end