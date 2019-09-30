# frozen_string_literal: true

module LedgerSync
  class Customer < LedgerSync::Resource
    attribute :email, type: :string
    attribute :name, type: :string
    attribute :phone_number, type: :string
  end
end
