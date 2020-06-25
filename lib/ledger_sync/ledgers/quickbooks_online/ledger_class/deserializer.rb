# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class LedgerClass
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute :Name
          attribute :Active
          attribute :SubClass
          attribute :FullyQualifiedName

          references_one :Parent,
                         hash_attribute: 'ParentRef',
                         deserializer: Reference::Deserializer
        end
      end
    end
  end
end
