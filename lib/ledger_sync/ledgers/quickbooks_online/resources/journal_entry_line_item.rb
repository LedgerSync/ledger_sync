# frozen_string_literal: true

require_relative 'account'
require_relative 'department'
require_relative 'ledger_class'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntryLineItem < QuickBooksOnline::Resource
        TYPES = {
          'debit' => 'Debit',
          'credit' => 'Credit'
        }.freeze

        references_one :account, to: Account
        references_one :department, to: Department
        references_one :ledger_class, to: LedgerClass
        attribute :amount, type: Type::Integer
        attribute :description, type: Type::String
        attribute :entry_type, type: Type::StringFromSet.new(values: TYPES.keys)

        def name
          description
        end
      end
    end
  end
end
