# frozen_string_literal: true

require_relative 'primary_phone'
require_relative 'primary_email_addr'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Vendor < QuickBooksOnline::Resource
        attribute :DisplayName, type: Type::String
        attribute :GivenName, type: Type::String
        attribute :MiddleName, type: Type::String
        attribute :FamilyName, type: Type::String
        attribute :CompanyName, type: Type::String

        references_one :PrimaryPhone, to: PrimaryPhone
        references_one :PrimaryEmailAddr, to: PrimaryEmailAddr

        def name
          self.DisplayName
        end
      end
    end
  end
end
