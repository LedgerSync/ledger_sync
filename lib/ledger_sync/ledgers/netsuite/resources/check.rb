# frozen_string_literal: true

require_relative 'check_line_item'
require_relative 'customer'
require_relative 'vendor'

module LedgerSync
  module Ledgers
    module NetSuite
      class Check < NetSuite::Resource
        attribute :memo, type: Type::String
        attribute :trandate, type: Type::String

        references_one :account
        references_one :department
        references_one :entity, to: [Customer, Vendor]
        references_one :currency

        references_many :line_items, to: CheckLineItem
      end
    end
  end
end
