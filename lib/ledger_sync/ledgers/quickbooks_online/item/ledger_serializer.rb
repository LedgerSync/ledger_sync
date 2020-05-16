# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Item
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id
        end
      end
    end
  end
end
