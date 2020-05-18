# frozen_string_literal: true

require_relative '../bill_line_item/serializer'
require_relative '../currency/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Bill
        class Serializer < QuickBooksOnline::Serializer
          id

          references_one :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::Serializer

          date 'DueDate',
               resource_attribute: :due_date

          attribute 'PrivateNote', resource_attribute: :memo

          date 'TxnDate',
               resource_attribute: :transaction_date

          attribute 'VendorRef.value',
                    resource_attribute: 'vendor.ledger_id'

          attribute 'APAccountRef.value',
                    resource_attribute: 'account.ledger_id'

          attribute 'DepartmentRef.value',
                    resource_attribute: 'department.ledger_id'

          attribute 'DocNumber',
                    resource_attribute: :reference_number

          references_many 'Line',
                          resource_attribute: :line_items,
                          serializer: BillLineItem::Serializer
        end
      end
    end
  end
end
