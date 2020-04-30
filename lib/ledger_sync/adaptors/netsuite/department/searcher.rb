# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Department
        class Searcher < Searcher
          def query_string
            "SELECT id, name, isinactive FROM department"
          end
        end
      end
    end
  end
end
