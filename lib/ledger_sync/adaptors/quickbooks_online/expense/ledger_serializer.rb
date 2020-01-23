# frozen_string_literal: true

require_relative '../expense_line_item/ledger_serializer'
require_relative '../currency/ledger_serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Expense
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id  ledger_attribute: 'Id',
              resource_attribute: :ledger_id

          references_one ledger_attribute: :CurrencyRef,
                          resource_attribute: :currency,
                          serializer: Currency::LedgerSerializer

          attribute ledger_attribute: 'PaymentType',
                    resource_attribute: :payment_type,
                    type: LedgerSerializerType::PaymentType

          attribute ledger_attribute: 'TxnDate',
                    resource_attribute: :transaction_date,
                    type: LedgerSerializerType::DateType

          attribute ledger_attribute: 'PrivateNote',
                    resource_attribute: :memo

          attribute ledger_attribute: 'ExchangeRate',
                    resource_attribute: :exchange_rate

          attribute ledger_attribute: 'EntityRef',
                    resource_attribute: :entity,
                    type: LedgerSerializerType::EntityReferenceType

          attribute ledger_attribute: 'DocNumber',
                    resource_attribute: :reference_number

          attribute ledger_attribute: 'AccountRef.value',
                    resource_attribute: 'account.ledger_id'

          references_many ledger_attribute: 'Line',
                          resource_attribute: :line_items,
                          serializer: ExpenseLineItem::LedgerSerializer
        end
      end
    end
  end
end
