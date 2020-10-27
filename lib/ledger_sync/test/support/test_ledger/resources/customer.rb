# frozen_string_literal: true

require_relative 'subsidiary'

module LedgerSync
  module Ledgers
    module TestLedger
      class Customer < TestLedger::Resource
        attribute :name, type: LedgerSync::Type::String
        attribute :email, type: LedgerSync::Type::String
        attribute :date, type: LedgerSync::Type::Date

        references_one :subsidiary, to: Subsidiary
        references_many :subsidiaries, to: Subsidiary
      end
    end
  end
end
