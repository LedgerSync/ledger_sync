# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Account
        class SearcherDeserializer < NetSuite::Deserializer
          id

          attribute :name,
                    ledger_attribute: :accountsearchdisplayname

          attribute :number,
                    ledger_attribute: :acctnumber

          attribute :account_type,
                    ledger_attribute: :accttype

          attribute :description

          attribute :active,
                    ledger_attribute: :isinactive,
                    type: Type::Deserializer::Active.new
        end
      end
    end
  end
end
