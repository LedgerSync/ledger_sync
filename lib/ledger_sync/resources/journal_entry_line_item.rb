module LedgerSync
  class JournalEntryLineItem < LedgerSync::Resource
    references_one :account, to: Account
    attribute :amount, type: Type::Integer
    attribute :description, type: Type::String
    attribute :entry_type, type: Type::String

    def name
      description
    end
  end
end
