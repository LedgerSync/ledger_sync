module LedgerSync
  class Account < LedgerSync::Resource
    attribute :name, type: Type::String
    attribute :account_type, type: Type::String
    attribute :account_sub_type, type: Type::String
  end
end
