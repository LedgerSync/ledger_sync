# frozen_string_literal: true

require_relative '../expense_line/serializer'
require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Expense
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute :DocNumber
          date :TxnDate
          attribute :PrivateNote
          attribute :ExchangeRate

          attribute :PaymentType,
                    type: LedgerSync::Serialization::Type::MappingType.new(hash: Expense::PAYMENT_TYPES)

          attribute('EntityRef') do |args = {}|
            resource = args.fetch(:resource)
            if resource.Entity
              {
                'name' => resource.Entity.name,
                'value' => resource.Entity.ledger_id,
                'type' => Client.ledger_resource_type_for(
                  resource_class: resource.Entity.class
                ).classify
              }
            end
          end

          references_one 'CurrencyRef',
                         resource_attribute: :Currency,
                         serializer: Reference::Serializer

          references_one 'AccountRef',
                         resource_attribute: :Account,
                         serializer: Reference::Serializer

          references_one 'DepartmentRef',
                         resource_attribute: :Department,
                         serializer: Reference::Serializer

          references_many 'Line',
                          resource_attribute: :Line,
                          serializer: ExpenseLine::Serializer
        end
      end
    end
  end
end
