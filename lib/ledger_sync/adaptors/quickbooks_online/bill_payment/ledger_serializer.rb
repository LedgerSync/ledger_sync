# frozen_string_literal: true

require_relative '../currency/ledger_serializer'
require_relative '../vendor/ledger_serializer'
require_relative '../department/ledger_serializer'
require_relative '../bill_payment_line_item/ledger_serializer'
require_relative '../reference/ledger_serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module BillPayment
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'TotalAmt',
                    resource_attribute: :amount,
                    type: LedgerSerializerType::AmountType

          references_one ledger_attribute: 'CurrencyRef',
                         resource_attribute: :currency,
                         serializer: Currency::LedgerSerializer

          references_one ledger_attribute: 'VendorRef',
                         resource_attribute: :vendor,
                         resource_class: LedgerSync::Vendor,
                         serializer: Reference::LedgerSerializer

          references_one ledger_attribute: 'DepartmentRef',
                        resource_attribute: :department,
                        resource_class: LedgerSync::Department,
                        serializer: Reference::LedgerSerializer

         references_one ledger_attribute: 'APAccountRef',
                        resource_attribute: :account,
                        resource_class: LedgerSync::Account,
                        serializer: Reference::LedgerSerializer

          attribute ledger_attribute: 'DocNumber',
                    resource_attribute: :reference_number

          attribute ledger_attribute: 'PrivateNote',
                    resource_attribute: :memo

          attribute ledger_attribute: 'ExchangeRate',
                    resource_attribute: :exchange_rate

          attribute ledger_attribute: 'TxnDate',
                    resource_attribute: :transaction_date,
                    type: LedgerSerializerType::DateType

          attribute ledger_attribute: 'PayType',
                    resource_attribute: :payment_type,
                    type: LedgerSerializerType::PaymentType

          references_one ledger_attribute: 'CheckPayment.BankAccountRef',
                         resource_attribute: :bank_account,
                         resource_class: LedgerSync::Account,
                         serializer: Reference::LedgerSerializer

          references_one ledger_attribute: 'CreditCardPayment.CCAccountRef',
                         resource_attribute: :credit_card_account,
                         resource_class: LedgerSync::Account,
                         serializer: Reference::LedgerSerializer

          references_many ledger_attribute: 'Line',
                          resource_attribute: :line_items,
                          serializer: BillPaymentLineItem::LedgerSerializer
        end
      end
    end
  end
end
