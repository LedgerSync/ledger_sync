# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module NetSuite
      class Check
        class Serializer < NetSuite::Serializer
          attribute :memo
          attribute :trandate

          references_one :account,
                         serializer: Reference::Serializer

          references_one :department,
                         serializer: Reference::Serializer

          references_one :currency,
                         serializer: Reference::Serializer

          references_one :entity,
                         serializer: Reference::Serializer

          references_many 'expense.items',
                          resource_attribute: :line_items,
                          serializer: CheckLineItem::Serializer
        end
      end
    end
  end
end
