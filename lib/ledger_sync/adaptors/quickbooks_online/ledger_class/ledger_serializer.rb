# frozen_string_literal: true

require_relative '../reference/ledger_serializer'

module LedgerSync
  module Adaptors
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

          references_one ledger_attribute: 'ParentRef',
                         resource_attribute: :parent,
                         resource_class: LedgerSync::LedgerClass,
                         serializer: Reference::LedgerSerializer
        end
      end
    end
  end
end
