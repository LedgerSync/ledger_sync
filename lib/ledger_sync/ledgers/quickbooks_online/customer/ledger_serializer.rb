# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Customer
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id  ledger_attribute: 'Id',
              resource_attribute: :ledger_id

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
