# frozen_string_literal: true

require 'ledger_sync/test/support'

LedgerSync::Test::Support.setup(:ledger_sync)

support :webmock_helpers
support :vcr
support :resource_helpers

core_support :test_ledger_helpers

setup_client_qa_support(
  *LedgerSync.ledgers.configs.values.map(&:client_class),
  keyed: true
)

RSpec.configure do |config|
  config.include(TestLedgerHelpers)
end
