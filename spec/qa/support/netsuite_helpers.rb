# frozen_string_literal: true

core_qa_support :ledger_helpers
qa_support :netsuite_shared_examples

module QA
  module NetSuiteHelpers
    include LedgerSync::Test::QA::LedgerHelpers

    def client_class
      LedgerSync::Ledgers::NetSuite::Client
    end

    def existing_account_resource
      LedgerSync::Ledgers::NetSuite::Account.new(
        ledger_id: 220
      )
    end

    def existing_customer_resource
      LedgerSync::Ledgers::NetSuite::Customer.new(
        ledger_id: 316,
        companyName: "QA Customer #{test_run_id}"
      )
    end

    def existing_netsuite_subsidiary_resource
      LedgerSync::Ledgers::NetSuite::Subsidiary.new(
        ledger_id: 2,
        name: "QA Subsidary #{test_run_id}"
      )
    end

    def netsuite_client
      @netsuite_client ||= LedgerSync.ledgers.netsuite.new(
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
  config.include QA::NetSuiteHelpers, qa: true, client: :netsuite
end
