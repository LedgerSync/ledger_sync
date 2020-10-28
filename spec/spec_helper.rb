# frozen_string_literal: true

require 'ledger_sync/test/support'

LedgerSync::Test::Support.setup(:ledger_sync)

support :webmock_helpers
support :vcr
support :resource_helpers

core_support :test_ledger_helpers

RSpec.configure do |config|
  config.include(TestLedgerHelpers)
end
