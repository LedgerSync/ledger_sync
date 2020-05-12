# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module LedgerClass
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'Name',
                    resource_attribute: :name
          attribute ledger_attribute: 'Active',
                    resource_attribute: :active
          attribute ledger_attribute: 'SubClass',
                    resource_attribute: :sub_class
          attribute ledger_attribute: 'FullyQualifiedName',
                    resource_attribute: :fully_qualified_name

          attribute ledger_attribute: 'ParentRef.value',
                    resource_attribute: 'parent.ledger_id'
        end
      end
    end
  end
end
