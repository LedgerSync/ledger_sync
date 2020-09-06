# frozen_string_literal: true

require_relative '../reference/serializer'
require_relative '../payment_line/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Payment
        class Serializer < QuickBooksOnline::Serializer
          id

          amount :TotalAmt
          attribute :PaymentRefNum
          attribute :PrivateNote
          attribute :ExchangeRate
          date :TxnDate

          references_one 'CurrencyRef',
                         resource_attribute: :Currency,
                         serializer: Reference::Serializer

          references_one 'CustomerRef',
                         resource_attribute: :Customer,
                         serializer: Reference::Serializer

          references_one 'DepositToAccountRef',
                         resource_attribute: :DepositToAccount,
                         serializer: Reference::Serializer

          references_one 'ARAccountRef',
                         resource_attribute: :ARAccount,
                         serializer: Reference::Serializer

          references_many 'Line',
                          resource_attribute: :Line,
                          serializer: PaymentLine::Serializer
        end
      end
    end
  end
end
