LedgerSync.register_adaptor(:test) do |config|
  config.test = true
  config.name = 'Test Ledger Adaptor'
  config.add_alias :test
  config.rate_limiting_wait_in_seconds = 47
end
