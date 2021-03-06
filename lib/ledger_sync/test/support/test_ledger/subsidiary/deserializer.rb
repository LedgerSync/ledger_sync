# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module TestLedger
      class Subsidiary
        class Deserializer < TestLedger::Deserializer
          id

          attribute :name

          attribute :state
        end
      end
    end
  end
end
