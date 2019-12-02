# frozen_string_literal: true

module LedgerSync
  class Txn < LedgerSync::Resource
    references_one :entity, to: [Expense, JournalEntry, Invoice]

    def name
      "Txn: #{entity.try(:name)}"
    end
  end
end
