# frozen_string_literal: true

core_qa_support :ledger_helpers

module QA
  module TestLedgerHelpers
  end
end

RSpec.configure do |config|
  config.include QA::TestLedgerHelpers, qa: true, client: :test_ledger
end
