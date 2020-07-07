# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Reference
        class Deserializer < QuickBooksOnline::Deserializer
          attribute :ledger_id, hash_attribute: :value
        end
      end
    end
  end
end
