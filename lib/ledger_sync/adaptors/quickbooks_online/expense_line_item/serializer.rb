# frozen_string_literal: true

pdb

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module ExpenseLineItem
        class Serializer < QuickBooksOnline::Serializer
          attribute ledger_attribute: 'DetailType' do
            'AccountBasedExpenseLineDetail'
          end

          attribute ledger_attribute: 'AccountBasedExpenseLineDetail.value' do |resource|
            resource.account&.ledger_id
          end

          attribute ledger_attribute: 'Amount' do |resource|
            local_to_qbo_amount(resource.amount)
          end

          attribute ledger_attribute: 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end
