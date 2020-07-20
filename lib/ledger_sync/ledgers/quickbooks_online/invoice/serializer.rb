# frozen_string_literal: true

require_relative '../invoice_line/serializer'
require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Invoice
        class Serializer < QuickBooksOnline::Serializer
          id

          date :TxnDate
          attribute :PrivateNote

          references_one 'CurrencyRef',
                         resource_attribute: :Currency,
                         serializer: Reference::Serializer

          references_one 'CustomerRef',
                         resource_attribute: :Customer,
                         serializer: Reference::Serializer

          references_one 'DepositToAccountRef',
                         resource_attribute: :DepositToAccount,
                         serializer: Reference::Serializer

          references_many 'Line',
                          resource_attribute: :Line,
                          serializer: InvoiceLine::Serializer
        end
      end
    end
  end
end
