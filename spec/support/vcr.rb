# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.debug_logger = File.open(File.join(LedgerSync.root, 'tmp/vcr.log'), 'w') if ENV['DEBUG']

  if ENV.key?('USE_DOTENV_ADAPTOR_SECRETS')
    netsuite_account_id_filler = 'vcr_netsuite_account_id'
    # These need to match the defaults in support/netsuite_helpers.rb for the
    # stubs to work.
    if ENV.key?('NETSUITE_ACCOUNT_ID')
      config.filter_sensitive_data(netsuite_account_id_filler) { ENV['NETSUITE_ACCOUNT_ID'] }
    end
    if ENV.key?('NETSUITE_CONSUMER_KEY')
      config.filter_sensitive_data('VCR_NETSUITE_CONSUMER_KEY') { ENV['NETSUITE_CONSUMER_KEY'] }
    end
    if ENV.key?('NETSUITE_CONSUMER_SECRET')
      config.filter_sensitive_data('VCR_NETSUITE_CONSUMER_SECRET') { ENV['NETSUITE_CONSUMER_SECRET'] }
    end
    config.filter_sensitive_data('VCR_NETSUITE_TOKEN_ID') { ENV['NETSUITE_TOKEN_ID'] } if ENV.key?('NETSUITE_TOKEN_ID')
    if ENV.key?('NETSUITE_TOKEN_SECRET')
      config.filter_sensitive_data('VCR_NETSUITE_TOKEN_SECRET') { ENV['NETSUITE_TOKEN_SECRET'] }
    end

    # These need to match the defaults in support/netsuite_soap_helpers.rb for the
    # stubs to work.
    if ENV.key?('NETSUITE_SOAP_ACCOUNT_ID')
      config.filter_sensitive_data(netsuite_account_id_filler) { ENV['NETSUITE_SOAP_ACCOUNT_ID'] }
    end
    if ENV.key?('NETSUITE_SOAP_CONSUMER_KEY')
      config.filter_sensitive_data('VCR_NETSUITE_SOAP_CONSUMER_KEY') { ENV['NETSUITE_SOAP_CONSUMER_KEY'] }
    end
    if ENV.key?('NETSUITE_SOAP_CONSUMER_SECRET')
      config.filter_sensitive_data('VCR_NETSUITE_SOAP_CONSUMER_SECRET') { ENV['NETSUITE_SOAP_CONSUMER_SECRET'] }
    end
    if ENV.key?('NETSUITE_SOAP_TOKEN_ID')
      config.filter_sensitive_data('VCR_NETSUITE_SOAP_TOKEN_ID') { ENV['NETSUITE_SOAP_TOKEN_ID'] }
    end
    if ENV.key?('NETSUITE_SOAP_TOKEN_SECRET')
      config.filter_sensitive_data('VCR_NETSUITE_SOAP_TOKEN_SECRET') { ENV['NETSUITE_SOAP_TOKEN_SECRET'] }
    end

    # These need to match the defaults in support/quickbooks_online_helpers.rb for the
    # stubs to work.
    if ENV.key?('QUICKBOOKS_ONLINE_ACCESS_TOKEN')
      config.filter_sensitive_data('VCR_QUICKBOOKS_ONLINE_ACCESS_TOKEN') { ENV['QUICKBOOKS_ONLINE_ACCESS_TOKEN'] }
    end
    if ENV.key?('QUICKBOOKS_ONLINE_CLIENT_ID')
      config.filter_sensitive_data('VCR_QUICKBOOKS_ONLINE_CLIENT_ID') { ENV['QUICKBOOKS_ONLINE_CLIENT_ID'] }
    end
    if ENV.key?('QUICKBOOKS_ONLINE_CLIENT_SECRET')
      config.filter_sensitive_data('VCR_QUICKBOOKS_ONLINE_CLIENT_SECRET') { ENV['QUICKBOOKS_ONLINE_CLIENT_SECRET'] }
    end
    if ENV.key?('QUICKBOOKS_ONLINE_REALM_ID')
      config.filter_sensitive_data('VCR_QUICKBOOKS_ONLINE_REALM_ID') { ENV['QUICKBOOKS_ONLINE_REALM_ID'] }
    end
    if ENV.key?('QUICKBOOKS_ONLINE_REFRESH_TOKEN')
      config.filter_sensitive_data('VCR_QUICKBOOKS_ONLINE_REFRESH_TOKEN') { ENV['QUICKBOOKS_ONLINE_REFRESH_TOKEN'] }
    end
  end
end

RSpec.configure do |config|
  config.around(:each) do |ex|
    if ex.metadata.key?(:vcr) && ex.metadata[:vcr] != false && !ex.metadata[:qa]
      ex.run
    else
      VCR.turned_off { ex.run }
    end
  end
end
