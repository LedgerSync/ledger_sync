# frozen_string_literal: true

require_relative '../subsidiary/serializer'

module LedgerSync
  module Ledgers
    module TestLedger
      class Customer
        class Serializer < TestLedger::Serializer
          id

          attribute :name
          attribute :email

          references_one :subsidiary
          references_many :subsidiaries
        end
      end
    end
  end
end
