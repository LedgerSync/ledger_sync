# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module TestLedger
      class Customer
        class Deserializer < TestLedger::Deserializer
          id

          attribute :name
          attribute :email
          attribute :date

          references_one :subsidiary, deserializer: Subsidiary::Deserializer
          references_many :subsidiaries, deserializer: Subsidiary::Deserializer
        end
      end
    end
  end
end
