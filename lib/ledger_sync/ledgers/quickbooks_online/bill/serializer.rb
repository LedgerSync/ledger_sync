# frozen_string_literal: true

require_relative '../bill_line/serializer'
require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Bill
        class Serializer < QuickBooksOnline::Serializer
          id

          date :DueDate
          date :TxnDate
          attribute :PrivateNote
          attribute :DocNumber

          references_one 'CurrencyRef',
                         resource_attribute: :Currency,
                         serializer: Reference::Serializer

          references_one 'VendorRef',
                         resource_attribute: :Vendor,
                         serializer: Reference::Serializer

          references_one 'APAccountRef',
                         resource_attribute: :APAccount,
                         serializer: Reference::Serializer

          references_one 'DepartmentRef',
                         resource_attribute: :Department,
                         serializer: Reference::Serializer


          references_many 'Line',
                          resource_attribute: :Line,
                          serializer: BillLine::Serializer
        end
      end
    end
  end
end
