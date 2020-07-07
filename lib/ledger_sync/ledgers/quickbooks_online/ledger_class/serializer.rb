# frozen_string_literal: true

require_relative '../reference/serializer'

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
          references_one 'ParentRef',
                         resource_attribute: :parent,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end
