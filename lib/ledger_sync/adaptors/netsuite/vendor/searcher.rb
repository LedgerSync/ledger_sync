module LedgerSync
  module Adaptors
    module NetSuite
      module Vendor
        class Searcher < Searcher
          def query_string
            "SELECT id, companyname, email, phone FROM vendor"
          end
        end
      end
    end
  end
end
