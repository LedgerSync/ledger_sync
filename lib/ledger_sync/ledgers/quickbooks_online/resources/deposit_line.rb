# frozen_string_literal: true

require_relative 'deposit_line_detail'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DepositLine < QuickBooksOnline::Resource
        references_one :DepositLineDetail, to: DepositLineDetail
        attribute :Amount, type: Type::Integer
        attribute :Description, type: Type::String

        def name
          self.Description
        end
      end
    end
  end
end
