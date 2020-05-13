# frozen_string_literal: true

require_relative 'account'
require_relative 'currency'
require_relative 'department'
require_relative 'deposit_line_item'

module LedgerSync
  module Bundles
    module ModernTreasury
      class Deposit < ModernTreasury::Resource
    attribute :memo, type: Type::String
    attribute :transaction_date, type: Type::Date
    attribute :exchange_rate, type: Type::Float

    references_one :account, to: Account
    references_one :department, to: Department
    references_one :currency, to: Currency

    references_many :line_items, to: DepositLineItem

    def name
      "Deposit: #{currency}"
    end
      end
    end
  end
end
