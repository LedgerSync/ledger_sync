# frozen_string_literal: true

require_relative '../reference/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Account
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute :Name
          attribute :AcctNum
          attribute :Description
          attribute :Active

          mapping :AccountType,
                  hash: Account::TYPES.invert
          mapping :AccountSubType,
                  hash: Account::SUB_TYPES.invert
          mapping :Classification,
                  hash: Account::CLASSIFICATIONS.invert

          references_one :Currency,
                         hash_attribute: :CurrencyRef,
                         deserializer: Reference::Deserializer
        end
      end
    end
  end
end
