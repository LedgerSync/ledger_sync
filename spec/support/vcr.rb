# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!

  # These need to match the defaults in support/netsuite_soap_helpers.rb for the
  # stubs to work.
  config.filter_sensitive_data('netsuite_account_id') { ENV['NETSUITE_ACCOUNT_ID'] } if ENV.key?('NETSUITE_ACCOUNT_ID')
  config.filter_sensitive_data('NETSUITE_CONSUMER_KEY') { ENV['NETSUITE_CONSUMER_KEY'] } if ENV.key?('NETSUITE_CONSUMER_KEY')
  config.filter_sensitive_data('NETSUITE_CONSUMER_SECRET') { ENV['NETSUITE_CONSUMER_SECRET'] } if ENV.key?('NETSUITE_CONSUMER_SECRET')
  config.filter_sensitive_data('NETSUITE_TOKEN_ID') { ENV['NETSUITE_TOKEN_ID'] } if ENV.key?('NETSUITE_TOKEN_ID')
  config.filter_sensitive_data('NETSUITE_TOKEN_SECRET') { ENV['NETSUITE_TOKEN_SECRET'] } if ENV.key?('NETSUITE_TOKEN_SECRET')
end
