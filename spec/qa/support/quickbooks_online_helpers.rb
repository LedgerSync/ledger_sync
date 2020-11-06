# frozen_string_literal: true

core_qa_support :ledger_helpers
qa_support :quickbooks_online_shared_examples

module QA
  module QuickBooksOnlineHelpers
    include LedgerSync::Test::QA::LedgerHelpers

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
end
