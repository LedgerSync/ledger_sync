# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Account
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute :Name
          attribute :AcctNum
          attribute :Description
          attribute :Active

          mapping :AccountType,
                  hash: Account::TYPES
          mapping :AccountSubType,
                  hash: Account::SUB_TYPES
          mapping :Classification,
                  hash: Account::CLASSIFICATIONS

          references_one :CurrencyRef,
                         resource_attribute: :Currency,
                         serializer: Reference::Serializer
        end
      end
    end
  end
end
