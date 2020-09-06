# frozen_string_literal: true

require_relative '../account_based_expense_line_detail/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class ExpenseLine
        class Deserializer < QuickBooksOnline::Deserializer
          id

          amount :Amount
          attribute :Description

          references_one :AccountBasedExpenseLineDetail,
                         hash_attribute: 'AccountBasedExpenseLineDetail',
                         deserializer: AccountBasedExpenseLineDetail::Deserializer
        end
      end
    end
  end
end
