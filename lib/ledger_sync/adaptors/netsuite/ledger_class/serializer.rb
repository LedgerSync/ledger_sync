# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module LedgerClass
        class Serializer < NetSuite::Serializer
          attribute :name
        end
      end
    end
  end
end
