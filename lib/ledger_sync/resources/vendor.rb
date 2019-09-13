module LedgerSync
  class Vendor < LedgerSync::Resource
    attribute :email, type: :string
    attribute :first_name, type: :string
    attribute :last_name, type: :string

    def name
      "#{first_name} #{last_name}"
    end
  end
end
