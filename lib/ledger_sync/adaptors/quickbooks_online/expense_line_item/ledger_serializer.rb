# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module ExpenseLineItem
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: 'Id', resource_attribute: :ledger_id

          attribute ledger_attribute: 'DetailType' do
            'AccountBasedExpenseLineDetail'
          end

          attribute ledger_attribute: 'AccountBasedExpenseLineDetail.AccountRef.value',
                    resource_attribute: 'account.ledger_id'

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
