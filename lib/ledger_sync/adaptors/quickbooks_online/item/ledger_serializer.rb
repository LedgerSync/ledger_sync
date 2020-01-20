# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Item
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id
        end
      end
    end
  end
end
