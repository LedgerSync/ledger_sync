# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class SalesItemLineDetail
        class Deserializer < QuickBooksOnline::Deserializer
          references_one :Item,
                         hash_attribute: 'ItemRef',
                         deserializer: Reference::Deserializer

          references_one :Class,
                         hash_attribute: 'ClassRef',
                         deserializer: Reference::Deserializer
        end
      end
    end
  end
end
