module LedgerSync
  class Vendor < LedgerSync::Resource
    attribute :email, type: Type::String
    attribute :first_name, type: Type::String
    attribute :last_name, type: Type::String

    def name
      "#{first_name} #{last_name}"
    end
  end
end
