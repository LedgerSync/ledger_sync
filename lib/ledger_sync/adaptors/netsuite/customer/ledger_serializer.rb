# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Customer
        class LedgerSerializer < NetSuite::LedgerSerializer
          netsuite_lib_class ::NetSuite::Records::Customer
        end
      end
    end
  end
end
