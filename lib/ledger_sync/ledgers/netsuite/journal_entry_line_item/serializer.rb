# frozen_string_literal: true

require_relative '../account/serializer'
require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module NetSuite
      class JournalEntryLineItem
        class Serializer < NetSuite::Serializer
          attribute :line
          attribute :entitytype
          attribute :credit
          attribute :debit
          # references_one :account,
          #                resource_attribute: :account,
          #                serializer: Account::Serializer

          references_one :account,
                         resource_attribute: :account,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end
