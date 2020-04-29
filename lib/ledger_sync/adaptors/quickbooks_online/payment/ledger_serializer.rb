# frozen_string_literal: true

require_relative '../currency/ledger_serializer'
require_relative '../payment_line_item/ledger_serializer'
require_relative '../reference/ledger_serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Payment
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'TotalAmt',
                    resource_attribute: :amount,
                    type: LedgerSerializerType::AmountType

          references_one ledger_attribute: 'CurrencyRef',
                         resource_attribute: :currency,
                         serializer: Currency::LedgerSerializer

          references_one ledger_attribute: 'CustomerRef',
                         resource_attribute: :customer,
                         resource_class: LedgerSync::Customer,
                         serializer: Reference::LedgerSerializer

          references_one ledger_attribute: 'DepositToAccountRef',
                         resource_attribute: :deposit_account,
                         resource_class: LedgerSync::Account,
                         serializer: Reference::LedgerSerializer

          references_one ledger_attribute: 'ARAccountRef',
                         resource_attribute: :account,
                         resource_class: LedgerSync::Account,
                         serializer: Reference::LedgerSerializer

          attribute ledger_attribute: 'PaymentRefNum',
                    resource_attribute: :reference_number

          attribute ledger_attribute: 'PrivateNote',
                    resource_attribute: :memo

          attribute ledger_attribute: 'ExchangeRate',
                    resource_attribute: :exchange_rate

          attribute ledger_attribute: 'TxnDate',
                    resource_attribute: :transaction_date,
                    type: LedgerSerializerType::DateType

          references_many ledger_attribute: 'Line',
                          resource_attribute: :line_items,
                          serializer: PaymentLineItem::LedgerSerializer
        end
      end
    end
  end
end
