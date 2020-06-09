# frozen_string_literal: true

require_relative '../bill_line_item/serializer'
require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Bill
        class Serializer < QuickBooksOnline::Serializer
          id

          references_one 'CurrencyRef',
                         resource_attribute: :currency,
                         serializer: Reference::Serializer

          date 'DueDate',
               resource_attribute: :due_date

          attribute 'PrivateNote',
                    resource_attribute: :memo

          date 'TxnDate',
               resource_attribute: :transaction_date

          references_one 'VendorRef',
                         resource_attribute: :vendor,
                         serializer: Reference::Serializer

          references_one 'APAccountRef',
                         resource_attribute: :account,
                         serializer: Reference::Serializer

          references_one 'DepartmentRef',
                         resource_attribute: :department,
                         serializer: Reference::Serializer

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
