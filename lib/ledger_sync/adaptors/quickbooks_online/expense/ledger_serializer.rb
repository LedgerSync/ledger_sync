# frozen_string_literal: true

require_relative '../expense_line_item/ledger_serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Expense
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id  ledger_attribute: 'Id',
              resource_attribute: :ledger_id

          attribute ledger_attribute: 'CurrencyRef.value',
                    resource_attribute: :currency

          attribute ledger_attribute: 'PaymentType',
                    resource_attribute: :payment_type,
                    type: LedgerSerializerType::Payment

          attribute ledger_attribute: 'CurrencyRef.value',
                    resource_attribute: :currency

          attribute ledger_attribute: 'TxnDate',
                    resource_attribute: :transaction_date,
                    type: LedgerSerializerType::Date

          attribute ledger_attribute: 'PrivateNote',
                    resource_attribute: :memo

          attribute ledger_attribute: 'ExchangeRate',
                    resource_attribute: :exchange_rate

          attribute ledger_attribute: 'EntityRef.value',
                    resource_attribute: 'vendor.ledger_id'

          attribute ledger_attribute: 'AccountRef.value',
                    resource_attribute: 'account.ledger_id'

          # attribute ledger_attribute: 'DisplayName',
          #           resource_attribute: 'name'

          references_many ledger_attribute: 'Line',
                          resource_attribute: :line_items,
                          serializer: ExpenseLineItem::LedgerSerializer
        end
      end
    end
  end
end
