# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Vendor
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute 'DisplayName',
                    resource_attribute: :display_name

          attribute 'GivenName',
                    resource_attribute: :first_name

          attribute 'FamilyName',
                    resource_attribute: :last_name

          attribute 'PrimaryEmailAddr.Address',
                    resource_attribute: :email
        end
      end
    end
  end
end
