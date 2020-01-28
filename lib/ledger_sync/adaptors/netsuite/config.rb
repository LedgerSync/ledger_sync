# frozen_string_literal: true

LedgerSync.register_adaptor(:netsuite, module_string: 'NetSuite') do |config|
  config.name = 'NetSuite REST'
end
