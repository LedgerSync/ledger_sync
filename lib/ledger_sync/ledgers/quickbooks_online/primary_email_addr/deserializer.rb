# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class PrimaryEmailAddr
        class Deserializer < QuickBooksOnline::Deserializer
          attribute :Address
        end
      end
    end
  end
end
