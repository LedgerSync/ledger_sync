# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Currency
        class Serializer < QuickBooksOnline::Serializer
          attribute :value,
                    resource_attribute: :symbol

          attribute :name
        end
      end
    end
  end
end
