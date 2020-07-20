# frozen_string_literal: true

require_relative 'bill'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPaymentLine < QuickBooksOnline::Resource
        attribute :Amount, type: Type::Integer

        references_many :LinkedTxn, to: [Bill]

        def name
          self.Amount
        end
      end
    end
  end
end
