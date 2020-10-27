# frozen_string_literal: true

require_relative 'account_based_expense_line_detail'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillLine < QuickBooksOnline::Resource
        references_one :AccountBasedExpenseLineDetail, to: AccountBasedExpenseLineDetail
        attribute :Amount, type: Type::Integer
        attribute :Description, type: Type::String

        def name
          description
        end
      end
    end
  end
end
