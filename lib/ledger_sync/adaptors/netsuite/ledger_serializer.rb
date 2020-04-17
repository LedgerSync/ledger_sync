# frozen_string_literal: true

require 'ledger_sync/adaptors/ledger_serializer'
Gem.find_files('ledger_sync/adaptors/netsuite/ledger_serializer_type/**/*.rb').each { |path| require path } # require adaptor-specific types

module LedgerSync
  module Adaptors
    module NetSuite
      class LedgerSerializer < Adaptors::LedgerSerializer
        def self.id(**keywords)
          super({ ledger_attribute: 'id', resource_attribute: :ledger_id }.merge(keywords))
        end
      end
    end
  end
end
