# frozen_string_literal: true

require 'ledger_sync/adaptors/ledger_serializer'

Gem.find_files('ledger_sync/adaptors/quickbooks_online/ledger_serializer_type/**/*.rb').each { |path| require path }

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class LedgerSerializer < Adaptors::LedgerSerializer
      end
    end
  end
end
