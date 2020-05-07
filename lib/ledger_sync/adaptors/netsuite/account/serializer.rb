# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Account
        class Serializer < NetSuite::Serializer
          attribute :name,
                    ledger_attribute: :acctname

          attribute :account_type,
                    ledger_attribute: :accttype

          attribute :number,
                    ledger_attribute: :acctnumber
        end
      end
    end
  end
end
