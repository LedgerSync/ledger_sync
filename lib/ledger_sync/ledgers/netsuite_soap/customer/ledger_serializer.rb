# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuiteSOAP
      module Customer
        class LedgerSerializer < NetSuiteSOAP::LedgerSerializer
          netsuite_lib_class ::NetSuite::Records::Customer
        end
      end
    end
  end
end
