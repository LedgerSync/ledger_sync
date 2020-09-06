# frozen_string_literal: true

require_relative '../deposit_line_detail/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DepositLine
        class Deserializer < QuickBooksOnline::Deserializer
          id

          amount :Amount
          attribute :Description

          references_one :DepositLineDetail,
                         hash_attribute: 'DepositLineDetail',
                         deserializer: DepositLineDetail::Deserializer
        end
      end
    end
  end
end
