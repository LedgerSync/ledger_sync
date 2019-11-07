# frozen_string_literal: true

LedgerSync.register_adaptor(:netsuite, module_string: 'NetSuite') do |config|
  config.name = 'NetSuite'
  config.add_alias :net_suite
  config.rate_limiting_wait_in_seconds = 60
end
