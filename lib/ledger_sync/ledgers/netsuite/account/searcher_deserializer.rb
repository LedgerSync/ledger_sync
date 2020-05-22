# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Account
        class SearcherDeserializer < NetSuite::Deserializer
          id

          attribute :name,
                    hash_attribute: :accountsearchdisplayname

          attribute :number,
                    hash_attribute: :acctnumber

          mapping :account_type,
                  hash_attribute: :accttype,
                  hash: Account::TYPES.invert

          attribute :description

          attribute :active,
                    hash_attribute: :isinactive,
                    type: Type::Deserializer::Active.new
        end
      end
    end
  end
end
