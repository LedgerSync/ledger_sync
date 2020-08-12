# frozen_string_literal: true

require_relative 'subsidiary'
require_relative 'primary_phone'
require_relative 'primary_email_addr'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Customer < QuickBooksOnline::Resource
        attribute :DisplayName, type: LedgerSync::Type::String
        attribute :GivenName, type: LedgerSync::Type::String
        attribute :FamilyName, type: LedgerSync::Type::String
        attribute :MiddleName, type: LedgerSync::Type::String

        references_one :PrimaryPhone, to: PrimaryPhone
        references_one :PrimaryEmailAddr, to: PrimaryEmailAddr
        # references_one :Subsidiary, to: Subsidiary

        def name
          self.DisplayName || [self.GivenName, self.FamilyName].join(' ')
        end
      end
    end
  end
end
