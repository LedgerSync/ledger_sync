# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Check
        class Serializer < NetSuite::Serializer
          attribute :memo
          attribute :trandate

          ledger_reference :account

          ledger_reference :department

          ledger_reference :currency

          ledger_reference :entity

          references_many 'expense.items',
                          resource_attribute: :line_items,
                          serializer: CheckLineItem::Serializer
        end
      end
    end
  end
end
