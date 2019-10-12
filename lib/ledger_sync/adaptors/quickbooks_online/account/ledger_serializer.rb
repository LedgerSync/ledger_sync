# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: 'Name', resource_attribute: :name
          attribute ledger_attribute: 'AccountType', resource_attribute: :account_type, type: LedgerSerializerType::Account
          attribute ledger_attribute: 'AccountSubType', resource_attribute: :account_sub_type, type: LedgerSerializerType::SubAccount
          attribute ledger_attribute: 'AcctNum', resource_attribute: :number
          attribute ledger_attribute: 'CurrencyRef.value', resource_attribute: :currency
          attribute ledger_attribute: 'Description', resource_attribute: :description
          attribute ledger_attribute: 'Active', resource_attribute: :active
        end
      end
    end
  end
end
