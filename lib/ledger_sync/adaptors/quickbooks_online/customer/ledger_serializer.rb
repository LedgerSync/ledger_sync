# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Customer
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'DisplayName',
                    resource_attribute: :name

          attribute ledger_attribute: 'PrimaryPhone.FreeFormNumber',
                    resource_attribute: :phone_number

          attribute ledger_attribute: 'PrimaryEmailAddr.Address',
                    resource_attribute: :email
        end
      end
    end
  end
end
