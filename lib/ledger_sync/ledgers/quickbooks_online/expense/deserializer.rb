# frozen_string_literal: true

require_relative '../expense_line_item/deserializer'
require_relative '../currency/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense
        class Deserializer < QuickBooksOnline::Deserializer
          references_one :currency,
                         hash_attribute: :CurrencyRef,
                         deserializer: Currency::Deserializer

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
                ledger_id: value['value'],
                display_name: value['name']
              )
            end
          end

          attribute :reference_number,
                    hash_attribute: 'DocNumber'

          attribute 'account.ledger_id',
                    hash_attribute: 'AccountRef.value'

          attribute 'department.ledger_id',
                    hash_attribute: 'DepartmentRef.value'

          references_many :line_items,
                          hash_attribute: 'Line',
                          deserializer: ExpenseLineItem::Deserializer
        end
      end
    end
  end
end
