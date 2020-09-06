# frozen_string_literal: true

require_relative '../deposit_line_detail/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DepositLine
        class Serializer < QuickBooksOnline::Serializer
          id

          amount :Amount
          attribute :Description

          attribute :DetailType do
            'DepositLineDetail'
          end

          references_one 'DepositLineDetail',
                         resource_attribute: :DepositLineDetail,
                         serializer: DepositLineDetail::Serializer
        end
      end
    end
  end
end
