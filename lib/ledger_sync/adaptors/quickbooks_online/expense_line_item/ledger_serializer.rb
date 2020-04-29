# frozen_string_literal: true

require_relative '../reference/ledger_serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module ExpenseLineItem
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: 'Id', resource_attribute: :ledger_id

          attribute ledger_attribute: 'DetailType' do
            'AccountBasedExpenseLineDetail'
          end

          references_one ledger_attribute: 'AccountBasedExpenseLineDetail.AccountRef',
                         resource_attribute: :account,
                         resource_class: LedgerSync::Account,
                         serializer: Reference::LedgerSerializer

          references_one ledger_attribute: 'AccountBasedExpenseLineDetail.ClassRef',
                         resource_attribute: :ledger_class,
                         resource_class: LedgerSync::LedgerClass,
                         serializer: Reference::LedgerSerializer

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
