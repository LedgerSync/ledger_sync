# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Records
        class Customer < QuickBooksOnline::Record
          attribute :email, type: LedgerSync::Type::String
          attribute :companyName, type: LedgerSync::Type::String
          attribute :firstName, type: LedgerSync::Type::String
          attribute :lastName, type: LedgerSync::Type::String
          attribute :phone, type: LedgerSync::Type::String

          references_one :subsidiary, to: Subsidiary
        end
      end
    end
  end
end
