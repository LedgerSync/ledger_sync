module LedgerSync
  class Vendor < LedgerSync::Resource
    attribute :first_name
    attribute :last_name

    def name
      "#{first_name} #{last_name}"
    end
  end
end
