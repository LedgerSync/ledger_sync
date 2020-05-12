# frozen_string_literal: true

qa_support :ledger_helpers,
           :netsuite_shared_examples

module QA
  module NetSuiteHelpers
    include LedgerHelpers

    def connection_class
      LedgerSync::Ledgers::NetSuite::Connection
    end

    def existing_subsidiary_resource
      LedgerSync::Subsidiary.new(
        ledger_id: 2,
        name: "QA Subsidary #{test_run_id}"
      )
    end

    def netsuite_connection
      @netsuite_connection ||= LedgerSync.ledgers.netsuite.new(
        account_id: ENV.fetch('NETSUITE_ACCOUNT_ID'),
        consumer_key: ENV.fetch('NETSUITE_CONSUMER_KEY'),
        consumer_secret: ENV.fetch('NETSUITE_CONSUMER_SECRET'),
        token_id: ENV.fetch('NETSUITE_TOKEN_ID'),
        token_secret: ENV.fetch('NETSUITE_TOKEN_SECRET')
      )
    end
  end
end

RSpec.configure do |config|
  config.include QA::NetSuiteHelpers, qa: true, connection: :netsuite
end
