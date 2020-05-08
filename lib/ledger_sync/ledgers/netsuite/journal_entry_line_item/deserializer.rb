# frozen_string_literal: true

require_relative '../account/deserializer'

module LedgerSync
  module Ledgers
    module NetSuite
      class JournalEntryLineItem
        class Deserializer < NetSuite::Deserializer
          attribute :line
          attribute :entitytype
          attribute :credit
          attribute :debit
          references_one :account,
                         hash_attribute: :account,
                         deserializer: Account::Deserializer

        end
      end
    end
  end
end
