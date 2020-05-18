# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerClass
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute 'Name',
                    resource_attribute: :name
          attribute 'Active',
                    resource_attribute: :active
          attribute 'SubClass',
                    resource_attribute: :sub_class
          attribute 'FullyQualifiedName',
                    resource_attribute: :fully_qualified_name
          attribute 'ParentRef.value',
                    resource_attribute: 'parent.ledger_id'
        end
      end
    end
  end
end
