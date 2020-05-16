# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Department
        class Serializer < NetSuite::Serializer
          attribute :name
        end
      end
    end
  end
end
