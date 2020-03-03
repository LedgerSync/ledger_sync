# frozen_string_literal: true

qa_support :adaptor_helpers,
           :netsuite_soap_shared_examples

module QA
  module NetSuiteSOAPHelpers
    include AdaptorHelpers

    def adaptor_class
      LedgerSync::Adaptors::NetSuiteSOAP::Adaptor
    end

    def existing_subsidiary_resource
      LedgerSync::Subsidiary.new(
        ledger_id: 2,
        name: "QA Subsidary #{test_run_id}"
      )
    end

    def netsuite_soap_adaptor
      @netsuite_soap_adaptor ||= LedgerSync.adaptors.netsuite_soap.new(
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
  config.include QA::NetSuiteSOAPHelpers, qa: true, adaptor: :netsuite_soap
end
