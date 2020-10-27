# frozen_string_literal: true

require_relative '../bill_line/deserializer'
require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Bill
        class Deserializer < QuickBooksOnline::Deserializer
          id

          date :DueDate
          date :TxnDate
          attribute :PrivateNote
          attribute :DocNumber

          references_one :Currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          references_one :Vendor,
                         hash_attribute: 'VendorRef',
                         deserializer: Reference::Deserializer

          references_one :APAccount,
                         hash_attribute: 'APAccountRef',
                         deserializer: Reference::Deserializer

          references_one :Department,
                         hash_attribute: 'DepartmentRef',
                         deserializer: Reference::Deserializer

          references_many :Line,
                          hash_attribute: 'Line',
                          deserializer: BillLine::Deserializer
        end
      end
    end
  end
end
