# frozen_string_literal: true

require_relative '../bill_line_item/ledger_serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Bill
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'CurrencyRef.value', resource_attribute: :currency

          attribute ledger_attribute: 'DueDate',
                    resource_attribute: :due_date,
                    type: LedgerSerializerType::Date

          attribute ledger_attribute: 'PrivateNote', resource_attribute: :memo

          attribute ledger_attribute: 'TxnDate',
                    resource_attribute: :transaction_date,
                    type: LedgerSerializerType::Date

          attribute ledger_attribute: 'VendorRef.value',
                    resource_attribute: 'vendor.ledger_id'

          attribute ledger_attribute: 'APAccountRef.value',
                    resource_attribute: 'account.ledger_id'

          references_many ledger_attribute: 'Line',
                          resource_attribute: :line_items,
                          serializer: BillLineItem::LedgerSerializer
        end
      end
    end
  end
end
