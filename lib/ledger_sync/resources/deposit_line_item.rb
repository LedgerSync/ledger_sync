module LedgerSync
  class DepositLineItem < LedgerSync::Resource
    references_one :account, to: Account
    attribute :amount, type: Type::Integer
    attribute :description, type: Type::String

    references_one :entity, to: [Customer, Vendor]

    def name
      description
    end
  end
end
