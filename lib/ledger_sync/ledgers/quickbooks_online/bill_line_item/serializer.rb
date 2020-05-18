# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillLineItem
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute 'DetailType' do
            'AccountBasedExpenseLineDetail'
          end

          attribute 'AccountBasedExpenseLineDetail.AccountRef.value',
                    resource_attribute: 'account.ledger_id'

          attribute 'AccountBasedExpenseLineDetail.ClassRef.value',
                    resource_attribute: 'ledger_class.ledger_id'

          amount 'Amount',
                 resource_attribute: :amount

          attribute 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end
