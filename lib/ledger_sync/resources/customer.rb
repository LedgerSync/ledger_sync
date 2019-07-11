module LedgerSync
  class Customer < LedgerSync::Resource
    attribute :email
    attribute :name
    attribute :phone_number
    # attribute :active
  end
end
