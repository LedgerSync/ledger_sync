# frozen_string_literal: true

require 'webmock/rspec'
require 'simplecov'
require 'coveralls'
Coveralls.wear!('rails')

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    Coveralls::SimpleCov::Formatter,
    SimpleCov::Formatter::HTMLFormatter
  ]
)

SimpleCov.start do
  add_filter 'lib/ledger_sync/util/debug.rb'
end

# Set an environment variable to determine when we are testing.  This
# prevents things like the QuickBooks Online adaptor overwriting
# environment variables with dummy values.
ENV['TEST_ENV'] = 'true'

require 'bundler/setup'
require 'ap'
require 'byebug'
require 'ledger_sync'

def support(*paths)
  paths.each do |path|
    require File.join(LedgerSync.root, 'spec/support/', path.to_s)
  end
end

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.debug_logger = File.open(File.join(LedgerSync.root, 'tmp/vcr.log'), 'w') if ENV['DEBUG']

  if ENV.key?('USE_DOTENV_ADAPTOR_SECRETS')
    netsuite_account_id_filler = 'netsuite_account_id'
    # These need to match the defaults in support/netsuite_helpers.rb for the
    # stubs to work.
    config.filter_sensitive_data(netsuite_account_id_filler) { ENV['NETSUITE_ACCOUNT_ID'] } if ENV.key?('NETSUITE_ACCOUNT_ID')
    config.filter_sensitive_data('NETSUITE_CONSUMER_KEY') { ENV['NETSUITE_CONSUMER_KEY'] } if ENV.key?('NETSUITE_CONSUMER_KEY')
    config.filter_sensitive_data('NETSUITE_CONSUMER_SECRET') { ENV['NETSUITE_CONSUMER_SECRET'] } if ENV.key?('NETSUITE_CONSUMER_SECRET')
    config.filter_sensitive_data('NETSUITE_TOKEN_ID') { ENV['NETSUITE_TOKEN_ID'] } if ENV.key?('NETSUITE_TOKEN_ID')
    config.filter_sensitive_data('NETSUITE_TOKEN_SECRET') { ENV['NETSUITE_TOKEN_SECRET'] } if ENV.key?('NETSUITE_TOKEN_SECRET')

    # These need to match the defaults in support/netsuite_soap_helpers.rb for the
    # stubs to work.
    config.filter_sensitive_data(netsuite_account_id_filler) { ENV['NETSUITE_SOAP_ACCOUNT_ID'] } if ENV.key?('NETSUITE_SOAP_ACCOUNT_ID')
    config.filter_sensitive_data('NETSUITE_SOAP_CONSUMER_KEY') { ENV['NETSUITE_SOAP_CONSUMER_KEY'] } if ENV.key?('NETSUITE_SOAP_CONSUMER_KEY')
    config.filter_sensitive_data('NETSUITE_SOAP_CONSUMER_SECRET') { ENV['NETSUITE_SOAP_CONSUMER_SECRET'] } if ENV.key?('NETSUITE_SOAP_CONSUMER_SECRET')
    config.filter_sensitive_data('NETSUITE_SOAP_TOKEN_ID') { ENV['NETSUITE_SOAP_TOKEN_ID'] } if ENV.key?('NETSUITE_SOAP_TOKEN_ID')
    config.filter_sensitive_data('NETSUITE_SOAP_TOKEN_SECRET') { ENV['NETSUITE_SOAP_TOKEN_SECRET'] } if ENV.key?('NETSUITE_SOAP_TOKEN_SECRET')

    # These need to match the defaults in support/quickbooks_online_helpers.rb for the
    # stubs to work.
    config.filter_sensitive_data('QUICKBOOKS_ONLINE_ACCESS_TOKEN') { ENV['QUICKBOOKS_ONLINE_ACCESS_TOKEN'] } if ENV.key?('QUICKBOOKS_ONLINE_ACCESS_TOKEN')
    config.filter_sensitive_data('QUICKBOOKS_ONLINE_CLIENT_ID') { ENV['QUICKBOOKS_ONLINE_CLIENT_ID'] } if ENV.key?('QUICKBOOKS_ONLINE_CLIENT_ID')
    config.filter_sensitive_data('QUICKBOOKS_ONLINE_CLIENT_SECRET') { ENV['QUICKBOOKS_ONLINE_CLIENT_SECRET'] } if ENV.key?('QUICKBOOKS_ONLINE_CLIENT_SECRET')
    config.filter_sensitive_data('QUICKBOOKS_ONLINE_REALM_ID') { ENV['QUICKBOOKS_ONLINE_REALM_ID'] } if ENV.key?('QUICKBOOKS_ONLINE_REALM_ID')
    config.filter_sensitive_data('QUICKBOOKS_ONLINE_REFRESH_TOKEN') { ENV['QUICKBOOKS_ONLINE_REFRESH_TOKEN'] } if ENV.key?('QUICKBOOKS_ONLINE_REFRESH_TOKEN')
  end
end

support :factory_bot
support :vcr

# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'tmp/rspec_history.txt'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.around(:each) do |ex|
    if ex.metadata.key?(:vcr) && ex.metadata[:vcr] != false
      ex.run
    else
      VCR.turned_off { ex.run }
    end
  end
end
