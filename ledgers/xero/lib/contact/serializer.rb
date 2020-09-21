# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Xero
      class Contact
        class Serializer < Xero::Serializer
          attribute 'ContactId',
                    resource_attribute: :ledger_id
          attribute :Name
          attribute :EmailAddress
        end
      end
    end
  end
end
