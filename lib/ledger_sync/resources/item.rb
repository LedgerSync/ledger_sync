module LedgerSync
  class Item < LedgerSync::Resource
    attribute :name, type: Type::String
    attribute :type, type: Type::CastableSymbol
  end
end
