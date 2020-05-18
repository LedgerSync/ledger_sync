# frozen_string_literal: true

require_relative '../currency/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Account
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute 'Name',
                    resource_attribute: :name
          mapping 'AccountType',
                  resource_attribute: :account_type,
                  hash: Account::TYPES
          mapping 'AccountSubType',
                  resource_attribute: :account_sub_type,
                  hash: Account::SUB_TYPES
          attribute 'AcctNum',
                    resource_attribute: :number
          mapping 'Classification',
                  resource_attribute: :classification,
                  hash: Account::CLASSIFICATIONS
          attribute 'Description',
                    resource_attribute: :description
          attribute 'Active',
                    resource_attribute: :active

          references_one :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::Serializer
        end
      end
    end
  end
end
