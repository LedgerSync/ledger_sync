# frozen_string_literal: true

core_qa_support :ledger_helpers
qa_support :netsuite_soap_shared_examples

module QA
  module NetSuiteSOAPHelpers
    include LedgerSync::Test::QA::LedgerHelpers

    def client_class
      LedgerSync::Ledgers::NetSuiteSOAP::Client
    end

    def existing_subsidiary_resource
      LedgerSync::Ledgers::NetSuiteSOAP::Subsidiary.new(
        ledger_id: 2,
        name: "QA Subsidary #{test_run_id}"
      )
    end

    def netsuite_soap_client
      @netsuite_soap_client ||= LedgerSync.ledgers.netsuite_soap.new(
        account_id: ENV.fetch('NETSUITE_SOAP_ACCOUNT_ID'),
        consumer_key: ENV.fetch('NETSUITE_SOAP_CONSUMER_KEY'),
        consumer_secret: ENV.fetch('NETSUITE_SOAP_CONSUMER_SECRET'),
        token_id: ENV.fetch('NETSUITE_SOAP_TOKEN_ID'),
        token_secret: ENV.fetch('NETSUITE_SOAP_TOKEN_SECRET')
      )
    end
  end
end

RSpec.configure do |config|
  config.include QA::NetSuiteSOAPHelpers, qa: true, client: :netsuite_soap
end
