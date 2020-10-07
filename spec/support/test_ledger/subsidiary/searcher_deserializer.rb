# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module TestLedger
      class Subsidiary
        class SearcherDeserializer < TestLedger::Deserializer
          id

          attribute :name
        end
      end
    end
  end
end
