# frozen_string_literal: true

require_relative '../primary_phone/serializer'
require_relative '../primary_email_addr/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Customer
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute :DisplayName
          attribute :GivenName
          attribute :FamilyName
          attribute :MiddleName

          references_one :PrimaryPhone,
                         serializer: PrimaryPhone::Serializer
          references_one :PrimaryEmailAddr,
                         serializer: PrimaryEmailAddr::Serializer
        end
      end
    end
  end
end
