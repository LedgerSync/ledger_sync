# frozen_string_literal: true

# require client-specific types
Gem.find_files('ledger_sync/ledgers/netsuite/type/**/*.rb').each { |path| require path }

module LedgerSync
  module Ledgers
    module NetSuite
      class Deserializer < LedgerSync::Deserializer
        include Mixins::InferConfigMixin

        def self.id
          attribute :ledger_id, hash_attribute: :id
        end
      end
    end
  end
end
