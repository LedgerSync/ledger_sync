# frozen_string_literal: true

qa_support :ledger_helpers,
           :netsuite_soap_shared_examples

module QA
  module NetSuiteSOAPHelpers
    include LedgerHelpers

    def connection_class
      LedgerSync::Ledgers::NetSuiteSOAP::Connection
    end

    def existing_subsidiary_resource
      LedgerSync::Subsidiary.new(
        ledger_id: 2,
        name: "QA Subsidary #{test_run_id}"
      )
    end

    def netsuite_soap_connection
      @netsuite_soap_connection ||= LedgerSync.ledgers.netsuite_soap.new(
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
  config.include QA::NetSuiteSOAPHelpers, qa: true, connection: :netsuite_soap
end
