# frozen_string_literal: true

require_relative 'client'

args = {
  base_module: LedgerSync::Ledgers::TestLedger,
  root_path: File.join(LedgerSync.root, 'lib/ledger_sync/test/support/test_ledger')
}

LedgerSync.register_ledger(:test_ledger, args) do |config|
  config.name = 'Test Ledger'
  config.add_alias :test
  config.rate_limiting_wait_in_seconds = 60
end
