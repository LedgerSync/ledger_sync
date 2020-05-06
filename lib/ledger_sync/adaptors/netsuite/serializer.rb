# frozen_string_literal: true

# require adaptor-specific types
Gem.find_files('ledger_sync/adaptors/netsuite/type/**/*.rb').each { |path| require path }

module LedgerSync
  module Adaptors
    module NetSuite
      class Serializer < LedgerSync::Serializer
      end
    end
  end
end
