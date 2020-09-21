# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Xero
      class Contact < Xero::Resource
        attribute :Name, type: LedgerSync::Type::String
        attribute :EmailAddress, type: LedgerSync::Type::String

        def name
          self.Name
        end
      end
    end
  end
end
