# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Account
        class Searcher < Searcher
          def query_string
            "SELECT id, accttype, acctnumber, currency, description, isinactive, accountsearchdisplayname AS acctname FROM account"
          end
        end
      end
    end
  end
end
