# frozen_string_literal: true

require_relative '../bill_line_item/deserializer'
require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Bill
        class Deserializer < QuickBooksOnline::Deserializer
          id

          references_one :currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          date :due_date,
               hash_attribute: 'DueDate'

          attribute :memo,
                    hash_attribute: 'PrivateNote'

          date :transaction_date,
               hash_attribute: 'TxnDate'

          references_one :vendor,
                         hash_attribute: 'VendorRef',
                         deserializer: Reference::Deserializer

          references_one :account,
                         hash_attribute: 'APAccountRef',
                         deserializer: Reference::Deserializer

          references_one :department,
                         hash_attribute: 'DepartmentRef',
                         deserializer: Reference::Deserializer

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
