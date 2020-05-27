# frozen_string_literal: true
module LedgerSync
  module Ledgers
    module NetSuite
      class Check < NetSuite::Resource
        attribute :memo, type: Type::String
        attribute :trandate, type: Type::String

        references_one :account, to: Account
        references_one :department, to: Department
        references_one :entity, to: [Customer, Vendor]
        references_one :currency, to: Currency

        references_many :line_items, to: CheckLineItem
      end
    end
  end
end
