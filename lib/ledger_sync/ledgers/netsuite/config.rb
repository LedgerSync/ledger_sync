# frozen_string_literal: true

LedgerSync.register_client(:netsuite, module_string: 'NetSuite') do |config|
  config.name = 'NetSuite REST'
end
