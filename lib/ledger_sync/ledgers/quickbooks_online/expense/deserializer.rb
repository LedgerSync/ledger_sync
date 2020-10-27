# frozen_string_literal: true

require_relative '../expense_line/deserializer'
require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute :DocNumber
          date :TxnDate
          attribute :PrivateNote

          attribute :ExchangeRate

          mapping :PaymentType,
                  hash: Expense::PAYMENT_TYPES.invert

          attribute(:Entity) do |args = {}|
            hash = args.fetch(:hash)
            value = hash['EntityRef']

            unless value.nil?
              Client.resource_from_ledger_type(
                type: value['type']
              ).new(
                ledger_id: value['value']
              )
            end
          end

          references_one :Currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          references_one :Account,
                         hash_attribute: 'AccountRef',
                         deserializer: Reference::Deserializer

          references_one :Department,
                         hash_attribute: 'DepartmentRef',
                         deserializer: Reference::Deserializer

          references_many :Line,
                          hash_attribute: 'Line',
                          deserializer: ExpenseLine::Deserializer
        end
      end
    end
  end
end
