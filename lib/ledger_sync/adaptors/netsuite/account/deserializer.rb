# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Account
        class Deserializer < NetSuite::Deserializer
          id

          attribute :name,
                    hash_attribute: :acctname

          attribute :account_type,
                    hash_attribute: :accttype

          attribute :number,
                    hash_attribute: :acctnumber
        end
      end
    end
  end
end
