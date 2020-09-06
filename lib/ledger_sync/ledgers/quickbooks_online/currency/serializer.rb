# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Currency
        class Serializer < QuickBooksOnline::Serializer
          attribute :value,
                    resource_attribute: :Symbol

          attribute :name,
                    resource_attribute: :Name
        end
      end
    end
  end
end
