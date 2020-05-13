# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Vendor
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'DisplayName',
                    resource_attribute: :display_name

          attribute ledger_attribute: 'GivenName',
                    resource_attribute: :first_name

          attribute ledger_attribute: 'FamilyName',
                    resource_attribute: :last_name

          attribute ledger_attribute: 'PrimaryEmailAddr.Address',
                    resource_attribute: :email
        end
      end
    end
  end
end
