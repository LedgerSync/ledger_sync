# frozen_string_literal: true

require_relative '../reference/deserializer'
require_relative '../bill_payment_line_item/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPayment
        class Deserializer < QuickBooksOnline::Deserializer
          id

          amount :amount,
                 hash_attribute: 'TotalAmt'

          references_one :currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          references_one :vendor,
                         hash_attribute: 'VendorRef',
                         deserializer: Reference::Deserializer

          references_one :account,
                         hash_attribute: 'APAccountRef',
                         deserializer: Reference::Deserializer

          references_one :department,
                         hash_attribute: 'DepartmentRef',
                         deserializer: Reference::Deserializer

          attribute :reference_number,
                    hash_attribute: 'DocNumber'

          attribute :memo,
                    hash_attribute: 'PrivateNote'

          attribute :exchange_rate,
                    hash_attribute: 'ExchangeRate'

          date :transaction_date,
               hash_attribute: 'TxnDate'

          mapping :payment_type,
                  hash_attribute: 'PayType',
                  hash: BillPayment::PAYMENT_TYPES.invert

          attribute 'credit_card_account.ledger_id',
                    hash_attribute: 'CreditCardPayment.CCAccountRef.value'

          attribute 'bank_account.ledger_id',
                    hash_attribute: 'CheckPayment.BankAccountRef.value'

          references_one :credit_card_account,
                         hash_attribute: 'CreditCardPayment.CCAccountRef',
                         deserializer: Reference::Deserializer

          references_one :bank_account,
                         hash_attribute: 'CheckPayment.BankAccountRef',
                         deserializer: Reference::Deserializer

          references_many :line_items,
                          hash_attribute: 'Line',
                          deserializer: BillPaymentLineItem::Deserializer
        end
      end
    end
  end
end
