module LedgerSync
  module Adaptors
    module NetSuite
      module Customer
        class Searcher < Searcher
          def query_string
            "SELECT id, companyname, email, phone FROM customer"
          end
        end
      end
    end
  end
end
