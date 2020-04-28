# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Account
        class Searcher < Searcher
          def query_string
            "SELECT id, accountsearchdisplayname, acctnumber, accttype, currency, description, isinactive FROM account"
          end
        end
      end
    end
  end
end
