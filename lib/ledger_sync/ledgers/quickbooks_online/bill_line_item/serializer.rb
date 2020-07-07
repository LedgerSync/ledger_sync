# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillLineItem
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute 'DetailType' do
            'AccountBasedExpenseLineDetail'
          end

          references_one 'AccountBasedExpenseLineDetail.AccountRef',
                         resource_attribute: :account,
                         serializer: Reference::Serializer

          references_one 'AccountBasedExpenseLineDetail.ClassRef',
                         resource_attribute: :ledger_class,
                         serializer: Reference::Serializer

          amount 'Amount',
                 resource_attribute: :amount

          attribute 'Description',
                    resource_attribute: :description
        end
      end
    end
  end
end
