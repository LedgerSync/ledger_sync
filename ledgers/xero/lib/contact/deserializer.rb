# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Xero
      class Contact
        class Deserializer < Xero::Deserializer
          attribute :ledger_id,
                    hash_attribute: 'ContactID'
          attribute :Name
          attribute :EmailAddress
        end
      end
    end
  end
end
