# frozen_string_literal: true

require_relative '../reference/deserializer'
require_relative '../bill_payment_line/deserializer'
require_relative '../credit_card_payment/deserializer'
require_relative '../check_payment/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPayment
        class Deserializer < QuickBooksOnline::Deserializer
          id

          amount :TotalAmt
          attribute :DocNumber
          attribute :PrivateNote
          attribute :ExchangeRate
          date :TxnDate

          mapping :PayType,
                  hash: BillPayment::PAYMENT_TYPES.invert

          references_one :Currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          references_one :Vendor,
                         hash_attribute: 'VendorRef',
                         deserializer: Reference::Deserializer

          references_one :APAccount,
                         hash_attribute: 'APAccountRef',
                         deserializer: Reference::Deserializer

          references_one :Department,
                         hash_attribute: 'DepartmentRef',
                         deserializer: Reference::Deserializer

          references_one :CreditCardPayment,
                         hash_attribute: 'CreditCardPayment',
                         deserializer: CreditCardPayment::Deserializer

          references_one :CheckPayment,
                         hash_attribute: 'CheckPayment',
                         deserializer: CheckPayment::Deserializer

          references_many :Line,
                          hash_attribute: 'Line',
                          deserializer: BillPaymentLine::Deserializer
        end
      end
    end
  end
end
