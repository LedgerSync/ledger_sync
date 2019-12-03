# frozen_string_literal: true

module LedgerSync
  class Customer < LedgerSync::Resource
    attribute :email, type: Type::String
    attribute :name, type: Type::String
    attribute :phone_number, type: Type::String

    references_one :subsidiary, to: Subsidiary

    def first_name
      return '' if name.blank?

      name.split(' ').first
    end

    def last_name
      return '' if name.blank?

      name.split(' ')[1..-1].join(' ')
    end
  end
end
