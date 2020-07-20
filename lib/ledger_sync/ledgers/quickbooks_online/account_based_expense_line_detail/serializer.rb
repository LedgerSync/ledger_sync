# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class AccountBasedExpenseLineDetail
        class Serializer < QuickBooksOnline::Serializer
          references_one 'AccountRef',
                         resource_attribute: :Account,
                         serializer: Reference::Serializer

          references_one 'ClassRef',
                         resource_attribute: :Class,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end
