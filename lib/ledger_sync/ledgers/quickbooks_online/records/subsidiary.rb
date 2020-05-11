# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Records
        class Subsidiary < QuickBooksOnline::Record
          attribute :name, type: LedgerSync::Type::String
          attribute :state, type: LedgerSync::Type::String
        end
      end
    end
  end
end
