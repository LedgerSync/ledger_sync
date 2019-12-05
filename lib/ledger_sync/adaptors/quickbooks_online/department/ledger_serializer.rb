# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Department
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id  ledger_attribute: 'Id',
              resource_attribute: :ledger_id

          attribute ledger_attribute: 'Name',
                    resource_attribute: :name
          attribute ledger_attribute: 'Active',
                    resource_attribute: :active
          attribute ledger_attribute: 'SubDepartment',
                    resource_attribute: :sub_department
          attribute ledger_attribute: 'FullyQualifiedName',
                    resource_attribute: :fully_qualified_name

          attribute ledger_attribute: 'ParentRef.value',
                    resource_attribute: 'parent.ledger_id'
        end
      end
    end
  end
end
