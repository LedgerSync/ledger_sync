# frozen_string_literal: true

LedgerSync.register_adaptor(:netsuite, module_string: 'NetSuite') do |config|
  config.name = 'NetSuite REST'
  config.rate_limiting_wait_in_seconds = 60
end
