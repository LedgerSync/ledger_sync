# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerClass
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute :Name
          attribute :Active
          attribute :SubClass
          attribute :FullyQualifiedName

          references_one 'ParentRef',
                         resource_attribute: :Parent,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end
