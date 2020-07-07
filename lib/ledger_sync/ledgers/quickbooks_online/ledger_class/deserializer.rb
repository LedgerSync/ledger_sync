# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerClass
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute :name,
                    hash_attribute: 'Name'

          attribute :active,
                    hash_attribute: 'Active'

          attribute :sub_class,
                    hash_attribute: 'SubClass'

          attribute :fully_qualified_name,
                    hash_attribute: 'FullyQualifiedName'

          references_one :parent,
                         hash_attribute: 'ParentRef',
                         deserializer: Reference::Deserializer
        end
      end
    end
  end
end
