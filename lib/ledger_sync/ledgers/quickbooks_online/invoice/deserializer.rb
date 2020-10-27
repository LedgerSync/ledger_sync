# frozen_string_literal: true

require_relative '../invoice_line/deserializer'
require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Invoice
        class Deserializer < QuickBooksOnline::Deserializer
          id

          date :TxnDate
          attribute :PrivateNote

          references_one :Currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          references_one :Customer,
                         hash_attribute: 'CustomerRef',
                         deserializer: Reference::Deserializer

          references_one :DepositToAccount,
                         hash_attribute: 'DepositToAccountRef',
                         deserialier: Reference::Deserializer

          references_many :Line,
                          hash_attribute: 'Line',
                          deserializer: InvoiceLine::Deserializer
        end
      end
    end
  end
end
