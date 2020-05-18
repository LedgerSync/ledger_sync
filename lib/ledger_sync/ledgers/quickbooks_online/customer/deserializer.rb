# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Customer
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute :DisplayName

          attribute 'PrimaryPhone.FreeFormNumber'

          attribute 'PrimaryEmailAddr.Address'
        end
      end
    end
  end
end
