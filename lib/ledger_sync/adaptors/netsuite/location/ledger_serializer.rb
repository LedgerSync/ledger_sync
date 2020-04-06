# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Location
        class LedgerSerializer < NetSuite::LedgerSerializer
          id

          api_resource_type :location
        end
      end
    end
  end
end
