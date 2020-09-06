# frozen_string_literal: true

require_relative '../primary_phone/deserializer'
require_relative '../primary_email_addr/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Customer
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute :DisplayName
          attribute :GivenName
          attribute :FamilyName
          attribute :MiddleName

          references_one :PrimaryPhone,
                         deserializer: PrimaryPhone::Deserializer
          references_one :PrimaryEmailAddr,
                         deserializer: PrimaryEmailAddr::Deserializer
        end
      end
    end
  end
end
