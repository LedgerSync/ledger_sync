# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Vendor
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute :display_name,
                    hash_attribute: 'DisplayName'

          attribute :first_name,
                    hash_attribute: 'GivenName'

          attribute :last_name,
                    hash_attribute: 'FamilyName'

          attribute :email,
                    hash_attribute: 'PrimaryEmailAddr.Address'
        end
      end
    end
  end
end
