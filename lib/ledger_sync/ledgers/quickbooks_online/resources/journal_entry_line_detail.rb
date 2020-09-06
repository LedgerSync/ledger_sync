# frozen_string_literal: true

require_relative 'account'
require_relative 'department'
require_relative 'ledger_class'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntryLineDetail < QuickBooksOnline::Resource
        TYPES = {
          'debit' => 'Debit',
          'credit' => 'Credit'
        }.freeze

        references_one :Account, to: Account
        references_one :Department, to: Department
        references_one :Class, to: LedgerClass
        attribute :PostingType, type: Type::StringFromSet.new(values: TYPES.keys)

        def name
          "#{self.PostingType} #{self.Account.try(:name)}"
        end
      end
    end
  end
end
