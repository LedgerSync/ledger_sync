# frozen_string_literal: true

require_relative 'subsidiary'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Vendor < QuickBooksOnline::Record
        attribute :company_name, type: Type::String
        attribute :email, type: Type::String
        attribute :display_name, type: Type::String
        attribute :first_name, type: Type::String
        attribute :last_name, type: Type::String
        attribute :phone_number, type: Type::String
        references_one :subsidiary, to: Subsidiary

        def name
          display_name.to_s
        end
      end
    end
  end
end
