# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Location < NetSuite::Resource
        attribute :name, type: Type::String
      end
    end
  end
end
