# frozen_string_literal: true

qa_support :ledger_helpers,
        :quickbooks_online_shared_examples

module QA
  module QuickBooksOnlineHelpers
    include LedgerHelpers

    def connection_class
      LedgerSync::Ledgers::QuickBooksOnline::Connection
    end

    def find_or_create_in_ledger(factory, qa: true, connection:)
      resource_class = FactoryBot.factories[factory].build_class
      searcher = connection.searcher_class_for(resource_type: resource_class.resource_type)
      resource = searcher.new(
        connection: connection,
        query: ''
      ).search.raise_if_error.resources.first

      return resource if resource.present?

      create_resource_for(
        connection: connection,
        resource: resource
      )
    end

    def quickbooks_online_connection
      @quickbooks_online_connection ||= LedgerSync.ledgers.quickbooks_online.new_from_env(test: true)
    end
  end
end

RSpec.configure do |config|
  config.include QA::QuickBooksOnlineHelpers, qa: true, connection: :quickbooks_online
  # config.before { quickbooks_online_connection.refresh! }
  config.around(:each, qa: true, connection: :quickbooks_online) do |example|
    example.run
  ensure
    quickbooks_online_connection.update_secrets_in_dotenv
  end
end
