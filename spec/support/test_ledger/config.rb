# frozen_string_literal: true

args = {
  module_string: 'TestLedger',
  root_path: File.join(LedgerSync.root, 'spec/support/test_ledger')
}

LedgerSync.register_ledger(:test_ledger, args) do |config|
  config.name = 'Test Ledger'
  config.add_alias :test
end
