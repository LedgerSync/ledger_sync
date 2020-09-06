# frozen_string_literal: true

require_relative '../account_based_expense_line_detail/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillLine
        class Serializer < QuickBooksOnline::Serializer
          id

          amount :Amount
          attribute :Description

          attribute :DetailType do
            'AccountBasedExpenseLineDetail'
          end

          references_one :AccountBasedExpenseLineDetail,
                         resource_attribute: 'AccountBasedExpenseLineDetail',
                         serializer: AccountBasedExpenseLineDetail::Serializer
        end
      end
    end
  end
end
