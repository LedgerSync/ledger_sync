# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module DepositLineItem
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'DetailType' do
            'DepositLineDetail'
          end

          attribute ledger_attribute: 'DepositLineDetail.AccountRef.value',
                    resource_attribute: 'account.ledger_id'

          attribute ledger_attribute: 'DepositLineDetail.ClassRef.value',
                    resource_attribute: 'ledger_class.ledger_id'

          attribute ledger_attribute: 'DepositLineDetail.Entity',
                    resource_attribute: :entity,
                    type: LedgerSerializerType::EntityReferenceType

          attribute ledger_attribute: 'Amount',
                    resource_attribute: :amount,
                    type: LedgerSerializerType::AmountType

          attribute ledger_attribute: 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end
