# frozen_string_literal: true

require_relative '../expense_line_item/serializer'
require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense
        class Serializer < QuickBooksOnline::Serializer
          id

          references_one 'CurrencyRef',
                         resource_attribute: :currency,
                         serializer: Reference::Serializer

          attribute 'PaymentType',
                    resource_attribute: :payment_type,
                    type: LedgerSync::Serialization::Type::MappingType.new(hash: Expense::PAYMENT_TYPES)

          date 'TxnDate',
               resource_attribute: :transaction_date

          attribute 'PrivateNote',
                    resource_attribute: :memo

          attribute 'ExchangeRate',
                    resource_attribute: :exchange_rate

          attribute('EntityRef') do |args = {}|
            resource = args.fetch(:resource)
            if resource.entity
              {
                'name' => resource.entity.name,
                'value' => resource.entity.ledger_id,
                'type' => Client.ledger_resource_type_for(
                  resource_class: resource.entity.class
                ).classify
              }
            end
          end

          attribute 'DocNumber',
                    resource_attribute: :reference_number

          references_one 'AccountRef',
                         resource_attribute: :account,
                         serializer: Reference::Serializer

          references_one 'DepartmentRef',
                         resource_attribute: :department,
                         serializer: Reference::Serializer

          references_many 'Line',
                          resource_attribute: :line_items,
                          serializer: ExpenseLineItem::Serializer
        end
      end
    end
  end
end
