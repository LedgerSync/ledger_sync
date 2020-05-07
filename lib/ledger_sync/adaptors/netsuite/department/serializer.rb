# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Department
        class Serializer < NetSuite::Serializer
          attribute :name
        end
      end
    end
  end
end
