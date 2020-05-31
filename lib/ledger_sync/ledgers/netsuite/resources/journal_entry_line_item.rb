# frozen_string_literal: true

require_relative 'account'
require_relative 'department'
require_relative 'ledger_class'

module LedgerSync
  module Ledgers
    module NetSuite
      class JournalEntryLineItem < NetSuite::Resource
        references_one :account, to: Account
        attribute :line, type: Type::Integer
        attribute :credit, type: Type::Float
        attribute :debit, type: Type::Float
        attribute :entitytype, type: Type::String

        def name
          description
        end
      end
    end
  end
end
