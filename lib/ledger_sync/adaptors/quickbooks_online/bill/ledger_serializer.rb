# frozen_string_literal: true

require_relative '../bill_line_item/ledger_serializer'
require_relative '../currency/ledger_serializer'
require_relative '../reference/ledger_serializer'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Bill
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          references_one ledger_attribute: 'CurrencyRef',
                         resource_attribute: :currency,
                         serializer: Currency::LedgerSerializer

          attribute ledger_attribute: 'DueDate',
                    resource_attribute: :due_date,
                    type: LedgerSerializerType::DateType

          attribute ledger_attribute: 'PrivateNote', resource_attribute: :memo

          attribute ledger_attribute: 'TxnDate',
                    resource_attribute: :transaction_date,
                    type: LedgerSerializerType::DateType

          references_one ledger_attribute: 'VendorRef',
                         resource_attribute: :vendor,
                         resource_class: LedgerSync::Vendor,
                         serializer: Reference::LedgerSerializer

          references_one ledger_attribute: 'APAccountRef',
                         resource_attribute: :account,
                         resource_class: LedgerSync::Account,
                         serializer: Reference::LedgerSerializer

          references_one ledger_attribute: 'DepartmentRef',
                         resource_attribute: :department,
                         resource_class: LedgerSync::Department,
                         serializer: Reference::LedgerSerializer

          attribute ledger_attribute: 'DocNumber',
                    resource_attribute: :reference_number

          references_many ledger_attribute: 'Line',
                          resource_attribute: :line_items,
                          serializer: BillLineItem::LedgerSerializer
        end
      end
    end
  end
end
