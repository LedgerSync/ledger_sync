# frozen_string_literal: true

require_relative '../currency/serializer'
require_relative '../department/serializer'
require_relative '../bill_payment_line_item/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class BillPayment
        class Serializer < QuickBooksOnline::Serializer
          id

          amount 'TotalAmt',
                 resource_attribute: :amount

          references_one :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::Serializer

          attribute 'VendorRef.value',
                    resource_attribute: 'vendor.ledger_id'

          attribute 'DepartmentRef.value',
                    resource_attribute: 'department.ledger_id'

          attribute 'APAccountRef.value',
                    resource_attribute: 'account.ledger_id'

          attribute 'DocNumber',
                    resource_attribute: :reference_number

          attribute 'PrivateNote',
                    resource_attribute: :memo

          attribute 'ExchangeRate',
                    resource_attribute: :exchange_rate

          date 'TxnDate',
               resource_attribute: :transaction_date

          mapping 'PayType',
                  resource_attribute: :payment_type,
                  hash: BillPayment::PAYMENT_TYPES

          attribute 'CreditCardPayment' do |args = {}|
            resource = args.fetch(:resource)

            if resource.credit_card_account
              {
                'CCAccountRef' => {
                  'value' => resource.credit_card_account.ledger_id
                }
              }
            end
          end

          attribute 'CheckPayment' do |args = {}|
            resource = args.fetch(:resource)

            if resource.bank_account
              {
                'BankAccountRef' => {
                  'value' => resource.bank_account.ledger_id
                }
              }
            end
          end

          references_many 'Line',
                          resource_attribute: :line_items,
                          serializer: BillPaymentLineItem::Serializer
        end
      end
    end
  end
end
