# frozen_string_literal: true

require_relative '../deposit_line/serializer'
require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Deposit
        class Serializer < QuickBooksOnline::Serializer
          id

          date :TxnDate
          attribute :PrivateNote
          attribute :ExchangeRate

          references_one 'CurrencyRef',
                         resource_attribute: :Currency,
                         serializer: Reference::Serializer

          references_one 'DepositToAccountRef',
                         resource_attribute: :DepositToAccount,
                         serializer: Reference::Serializer

          references_one 'DepartmentRef',
                         resource_attribute: :Department,
                         serializer: Reference::Serializer

          references_many 'Line',
                          resource_attribute: :Line,
                          serializer: DepositLine::Serializer
        end
      end
    end
  end
end
