# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Check
        class Serializer < NetSuite::Serializer
          attribute :memo
          attribute :trandate

          attribute :account,
                    type: Type::SerializerReferenceType.new

          attribute :department,
                    type: Type::SerializerReferenceType.new

          attribute :entity,
                    type: Type::SerializerReferenceType.new

          attribute :currency,
                    type: Type::SerializerReferenceType.new

	        references_many 'expense.items',
                           resource_attribute: :line_items,
                           serializer: CheckLineItem::Serializer

        end
      end
    end
  end
end
