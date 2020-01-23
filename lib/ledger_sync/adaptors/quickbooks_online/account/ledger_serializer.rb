# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: 'Id',
                    resource_attribute: :ledger_id
          attribute ledger_attribute: 'Name',
                    resource_attribute: :name
          attribute ledger_attribute: 'AccountType',
                    resource_attribute: :account_type,
                    type: LedgerSerializerType::AccountType
          attribute ledger_attribute: 'AccountSubType',
                    resource_attribute: :account_sub_type,
                    type: LedgerSerializerType::AccountSubType
          attribute ledger_attribute: 'AcctNum',
                    resource_attribute: :number
          attribute ledger_attribute: 'Classification',
                    resource_attribute: :classification,
                    type: LedgerSerializerType::ClassificationType
          attribute ledger_attribute: 'Description',
                    resource_attribute: :description
          attribute ledger_attribute: 'Active',
                    resource_attribute: :active

          references_one ledger_attribute: :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::LedgerSerializer
        end
      end
    end
  end
end
