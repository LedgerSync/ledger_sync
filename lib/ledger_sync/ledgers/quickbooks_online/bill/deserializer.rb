# frozen_string_literal: true

require_relative '../bill_line_item/deserializer'
require_relative '../currency/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Bill
        class Deserializer < QuickBooksOnline::Deserializer
          id

          references_one :currency,
                         hash_attribute: :CurrencyRef,
                         deserializer: Currency::Deserializer

          date :due_date,
               hash_attribute: 'DueDate'

          attribute :memo,
                    hash_attribute: 'PrivateNote'

          date :transaction_date,
               hash_attribute: 'TxnDate'

          attribute 'vendor.ledger_id',
                    hash_attribute: 'VendorRef.value'

          attribute 'account.ledger_id',
                    hash_attribute: 'APAccountRef.value'

          attribute 'department.ledger_id',
                    hash_attribute: 'DepartmentRef.value'

          attribute :reference_number,
                    hash_attribute: 'DocNumber'

          references_many :line_items,
                          hash_attribute: 'Line',
                          deserializer: BillLineItem::Deserializer
        end
      end
    end
  end
end
