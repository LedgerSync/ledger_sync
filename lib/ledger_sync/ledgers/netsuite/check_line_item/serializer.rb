# frozen_string_literal: true

require_relative '../account/serializer'
require_relative '../department/serializer'
require_relative '../ledger_class/serializer'

module LedgerSync
  module Ledgers
    module NetSuite
      class CheckLineItem
        class Serializer < NetSuite::Serializer
          attribute :amount
          attribute :memo

          attribute :account,
                    type: Type::SerializerReferenceType.new

          attribute :department,
                    type: Type::SerializerReferenceType.new

          attribute :ledger_class,
                    type: Type::SerializerReferenceType.new
        end
      end
    end
  end
end
