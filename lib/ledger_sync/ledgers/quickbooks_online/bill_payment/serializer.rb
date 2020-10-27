# frozen_string_literal: true

require_relative '../reference/serializer'
require_relative '../bill_payment_line/serializer'
require_relative '../credit_card_payment/serializer'
require_relative '../check_payment/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPayment
        class Serializer < QuickBooksOnline::Serializer
          id

          amount :TotalAmt
          attribute :DocNumber
          attribute :PrivateNote
          attribute :ExchangeRate
          date :TxnDate

          mapping :PayType,
                  hash: BillPayment::PAYMENT_TYPES

          references_one 'CurrencyRef',
                         resource_attribute: :Currency,
                         serializer: Reference::Serializer

          references_one 'VendorRef',
                         resource_attribute: :Vendor,
                         serializer: Reference::Serializer

          references_one 'DepartmentRef',
                         resource_attribute: :Department,
                         serializer: Reference::Serializer

          references_one 'APAccountRef',
                         resource_attribute: :APAccount,
                         serializer: Reference::Serializer

          references_one 'CreditCardPayment',
                         resource_attribute: :CreditCardPayment,
                         serializer: CreditCardPayment::Serializer

          references_one 'CheckPayment',
                         resource_attribute: :CheckPayment,
                         serializer: CheckPayment::Serializer

          references_many 'Line',
                          resource_attribute: :Line,
                          serializer: BillPaymentLine::Serializer
        end
      end
    end
  end
end
