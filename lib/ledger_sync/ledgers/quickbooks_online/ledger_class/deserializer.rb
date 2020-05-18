# frozen_string_literal: true

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

          attribute 'parent.ledger_id',
                    hash_attribute: 'ParentRef.value'

        end
      end
    end
  end
end
