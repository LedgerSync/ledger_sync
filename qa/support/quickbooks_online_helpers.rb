# frozen_string_literal: true

support :adaptor_helpers,
        :quickbooks_online_shared_examples

module QuickBooksOnlineHelpers
  include AdaptorHelpers

  def adaptor_class
    LedgerSync::Adaptors::QuickBooksOnline::Adaptor
  end

  def find_or_create_in_ledger(factory, adaptor:)
    resource_class = FactoryBot.factories[factory].build_class
    searcher = adaptor.searcher_klass_for(resource_type: resource_class.resource_type)
    resource = searcher.new(
      adaptor: adaptor,
      query: ''
    ).search.raise_if_error.resources.first

    return resource if resource.present?

    create_resource_for(
      adaptor: adaptor,
      resource: resource
    )
  end

  def quickbooks_online_adaptor
    @quickbooks_online_adaptor ||= LedgerSync.adaptors.quickbooks_online.new_from_env(test: true)
  end
end

RSpec.configure do |config|
  config.include QuickBooksOnlineHelpers, adaptor: :quickbooks_online
  # config.before { quickbooks_online_adaptor.refresh! }
  config.around(:each, adaptor: :quickbooks_online) do |example|
    example.run
  ensure
    quickbooks_online_adaptor.update_secrets_in_dotenv
  end
end
