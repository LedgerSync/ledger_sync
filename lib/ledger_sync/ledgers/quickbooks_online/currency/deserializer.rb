# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Currency
        class Deserializer < QuickBooksOnline::Deserializer
          attribute :Symbol,
                    hash_attribute: :value

          attribute :Name
        end
      end
    end
  end
end
