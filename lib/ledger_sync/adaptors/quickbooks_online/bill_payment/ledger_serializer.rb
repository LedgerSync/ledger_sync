# frozen_string_literal: true

require_relative '../currency/ledger_serializer'
require_relative '../vendor/ledger_serializer'
require_relative '../department/ledger_serializer'
require_relative '../bill_payment_line_item/ledger_serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module BillPayment
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'TotalAmt',
                    resource_attribute: :amount,
                    type: Adaptors::LedgerSerializerType::AmountType

          references_one ledger_attribute: :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::LedgerSerializer

          attribute ledger_attribute: 'VendorRef.value',
                    resource_attribute: 'vendor.ledger_id'

          attribute ledger_attribute: 'DepartmentRef.value',
                    resource_attribute: 'department.ledger_id'

          attribute ledger_attribute: 'APAccountRef.value',
                    resource_attribute: 'account.ledger_id'

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

          attribute ledger_attribute: 'CreditCardPayment' do |res|
            if res.credit_card_account
              {
                'CCAccountRef' => {
                  'value' => res.credit_card_account.ledger_id
                }
              }
            end
          end

          attribute ledger_attribute: 'CheckPayment' do |res|
            if res.bank_account
              {
                'BankAccountRef' => {
                  'value' => res.bank_account.ledger_id
                }
              }
            end
          end

          references_many ledger_attribute: 'Line',
                          resource_attribute: :line_items,
                          serializer: BillPaymentLineItem::LedgerSerializer
        end
      end
    end
  end
end
