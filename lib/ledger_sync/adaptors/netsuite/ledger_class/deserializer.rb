# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module LedgerClass
        class Deserializer < NetSuite::Deserializer
          id

          attribute :name
        end
      end
    end
  end
end
