# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Department
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute :Name
          attribute :Active
          attribute :SubDepartment
          attribute :FullyQualifiedName

          references_one :Parent,
                         hash_attribute: 'ParentRef',
                         deserializer: Reference::Deserializer
        end
      end
    end
  end
end
