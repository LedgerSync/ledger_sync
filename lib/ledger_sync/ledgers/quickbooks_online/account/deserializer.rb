# frozen_string_literal: true

require_relative '../currency/deserializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Account
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute :name,
                    hash_attribute: 'Name'

          mapping :account_type,
                  hash_attribute: 'AccountType',
                  hash: Account::TYPES.invert

          mapping :account_sub_type,
                  hash_attribute: 'AccountSubType',
                  hash: Account::SUB_TYPES.invert

          attribute :number,
                    hash_attribute: 'AcctNum'

          mapping :classification,
                  hash_attribute: 'Classification',
                  hash: Account::CLASSIFICATIONS.invert

          attribute :description,
                    hash_attribute: 'Description'

          attribute :active,
                    hash_attribute: 'Active'

          references_one :currency,
                         hash_attribute: :CurrencyRef,
                         deserializer: Currency::Deserializer
        end
      end
    end
  end
end
