# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class AccountBasedExpenseLineDetail
        class Deserializer < QuickBooksOnline::Deserializer
          references_one :Account,
                         hash_attribute: 'AccountRef',
                         deserializer: Reference::Deserializer

          references_one :Class,
                         hash_attribute: 'ClassRef',
                         deserializer: Reference::Deserializer
        end
      end
    end
  end
end
