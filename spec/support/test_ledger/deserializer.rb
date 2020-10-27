# frozen_string_literal: true

# Gem.find_files('ledger_sync/core/ledgers/test_ledger/serializer_type/**/*.rb').each { |path| require path }

module LedgerSync
  module Ledgers
    module TestLedger
      class Deserializer < LedgerSync::Deserializer
        def self.id
          attribute(:ledger_id, hash_attribute: 'Id')
        end
      end
    end
  end
end
