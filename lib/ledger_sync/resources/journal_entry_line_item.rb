# frozen_string_literal: true

require_relative 'account'
require_relative 'department'
require_relative 'ledger_class'

module LedgerSync
  class JournalEntryLineItem < LedgerSync::Resource
    references_one :account, to: Account
    references_one :department, to: Department
    references_one :ledger_class, to: LedgerClass
    attribute :amount, type: Type::Integer
    attribute :description, type: Type::String
    attribute :entry_type, type: Type::String

    def name
      description
    end
  end
end
