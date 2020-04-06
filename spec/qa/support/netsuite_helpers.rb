# frozen_string_literal: true

qa_support :adaptor_helpers,
           :netsuite_shared_examples

module QA
  module NetSuiteHelpers
    include AdaptorHelpers

    def adaptor_class
      LedgerSync::Adaptors::NetSuite::Adaptor
    end

    def existing_subsidiary_resource
      LedgerSync::Subsidiary.new(
        ledger_id: 2,
        name: "QA Subsidary #{test_run_id}"
      )
    end

    def find_first_in_netsuite(args = {})
      use_adaptor   = args.fetch(:adaptor, adaptor)
      resource_type = args.fetch(:resource_type)
      query         = args.fetch(:query, '')

      adaptor.searcher_class_for(
        resource_type: resource_type
      ).new(
        adaptor: use_adaptor,
        query: query
      ).resources.first
    end

    def netsuite_adaptor
      @netsuite_adaptor ||= LedgerSync.adaptors.netsuite.new(
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
  config.include QA::NetSuiteHelpers, qa: true, adaptor: :netsuite
end
