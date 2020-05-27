# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Check
        class Deserializer < NetSuite::Deserializer
          id

          attribute :memo
          attribute :trandate

          attribute :account,
                    type: Type::DeserializerAccountType.new(account_class: Account)

          attribute :currency,
                    type: Type::DeserializerCurrencyType.new(currency_class: Currency)

          attribute :department,
                    type: Type::DeserializerDepartmentType.new(department_class: Account)

          attribute :entity,
                    type: Type::DeserializerEntityType.new

          references_many :line_items,
                         hash_attribute: 'expense.items',
                         deserializer: CheckLineItem::Deserializer
        end
      end
    end
  end
end
