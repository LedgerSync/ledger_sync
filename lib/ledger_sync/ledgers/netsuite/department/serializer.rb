# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      module Department
        class Serializer < NetSuite::Serializer
          attribute :name
        end
      end
    end
  end
end
