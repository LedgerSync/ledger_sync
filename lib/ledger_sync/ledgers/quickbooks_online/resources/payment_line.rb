# frozen_string_literal: true

require_relative 'invoice'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class PaymentLine < QuickBooksOnline::Resource
        attribute :Amount, type: Type::Integer

        references_many :LinkedTxn, to: [Invoice]

        def name
          self.Amount
        end
      end
    end
  end
end
