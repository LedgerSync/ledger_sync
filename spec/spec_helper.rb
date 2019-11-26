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

require 'bundler/setup'
require 'ap'
require 'byebug'
require 'ledger_sync'

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock

  # These need to match the defaults in support/netsuite_helpers.rb for the
  # stubs to work.
  config.filter_sensitive_data('netsuite_account_id') { ENV['NETSUITE_ACCOUNT_ID'] } if ENV.key?('NETSUITE_ACCOUNT_ID')
  config.filter_sensitive_data('NETSUITE_CONSUMER_KEY') { ENV['NETSUITE_CONSUMER_KEY'] } if ENV.key?('NETSUITE_CONSUMER_KEY')
  config.filter_sensitive_data('NETSUITE_CONSUMER_SECRET') { ENV['NETSUITE_CONSUMER_SECRET'] } if ENV.key?('NETSUITE_CONSUMER_SECRET')
  config.filter_sensitive_data('NETSUITE_TOKEN_ID') { ENV['NETSUITE_TOKEN_ID'] } if ENV.key?('NETSUITE_TOKEN_ID')
  config.filter_sensitive_data('NETSUITE_TOKEN_SECRET') { ENV['NETSUITE_TOKEN_SECRET'] } if ENV.key?('NETSUITE_TOKEN_SECRET')
end

# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'tmp/rspec_history.txt'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def support(*paths)
  paths.each do |path|
    require File.join(LedgerSync.root, 'spec/support/', path.to_s)
  end
end
