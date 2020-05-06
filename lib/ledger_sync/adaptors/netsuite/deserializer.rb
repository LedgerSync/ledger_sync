# frozen_string_literal: true

# require adaptor-specific types
Gem.find_files('ledger_sync/adaptors/netsuite/type/**/*.rb').each { |path| require path }

module LedgerSync
  module Adaptors
    module NetSuite
      class Deserializer < LedgerSync::Deserializer
        def self.id
          attribute :ledger_id, hash_attribute: :id
        end
      end
    end
  end
end
