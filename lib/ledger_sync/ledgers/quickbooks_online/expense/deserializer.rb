# frozen_string_literal: true

require_relative '../expense_line_item/deserializer'
require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense
        class Deserializer < QuickBooksOnline::Deserializer
          id

          references_one :currency,
                         hash_attribute: 'CurrencyRef',
                         deserializer: Reference::Deserializer

          mapping :payment_type,
                  hash_attribute: 'PaymentType',
                  hash: Expense::PAYMENT_TYPES.invert

          date :transaction_date,
               hash_attribute: 'TxnDate'

          attribute :memo,
                    hash_attribute: 'PrivateNote'

          attribute :exchange_rate,
                    hash_attribute: 'ExchangeRate'

          attribute(:entity) do |args = {}|
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

          attribute :reference_number,
                    hash_attribute: 'DocNumber'

          references_one :account,
                         hash_attribute: 'AccountRef',
                         deserializer: Reference::Deserializer

          references_one :department,
                         hash_attribute: 'DepartmentRef',
                         deserializer: Reference::Deserializer

          references_many :line_items,
                          hash_attribute: 'Line',
                          deserializer: ExpenseLineItem::Deserializer
        end
      end
    end
  end
end
