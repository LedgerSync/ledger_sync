# frozen_string_literal: true

qa_support :ledger_helpers,
           :quickbooks_online_shared_examples

module QA
  module QuickBooksOnlineHelpers
    include LedgerHelpers

    def client_class
      LedgerSync::Ledgers::QuickBooksOnline::Client
    end

    def find_or_create_in_ledger(factory, client:)
      resource_class = FactoryBot.factories[factory].build_class
      searcher = client.searcher_class_for(resource_type: resource_class.resource_type)
      resource = searcher.new(
        client: client,
        query: ''
      ).search.raise_if_error.resources.first

      return resource if resource.present?

      create_resource_for(
        client: client,
        resource: resource
      )
    end

    def quickbooks_online_client
      @quickbooks_online_client ||= LedgerSync.ledgers.quickbooks_online.new_from_env(test: true)
    end
  end
end

RSpec.configure do |config|
  config.include QA::QuickBooksOnlineHelpers, qa: true, client: :quickbooks_online
  # config.before { quickbooks_online_client.refresh! }
  config.around(:each, qa: true, client: :quickbooks_online) do |example|
    example.run
  ensure
    quickbooks_online_client.update_secrets_in_dotenv
  end
end
