module LedgerSync
  class Item < LedgerSync::Resource
    attribute :name, type: Type::String
  end
end
