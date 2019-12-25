# frozen_string_literal: true

support :adaptor_helpers,
        :quickbooks_online_shared_examples

module QuickBooksOnlineHelpers
  include AdaptorHelpers

  def adaptor_class
    LedgerSync::Adaptors::QuickBooksOnline::Adaptor
  end

  def quickbooks_online_adaptor
    @quickbooks_online_adaptor ||= LedgerSync.adaptors.quickbooks_online.new_from_env(test: true)
  end
end

RSpec.configure do |config|
  config.include QuickBooksOnlineHelpers, adaptor: :quickbooks_online
  config.before { quickbooks_online_adaptor.refresh!(update_dotenv_secrets: true) }
  config.around do |example|
    example.run
  ensure
    quickbooks_online_adaptor.update_secrets_in_dotenv
  end
end
