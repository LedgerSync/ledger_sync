LedgerSync.register_adaptor(:quickbooks_online) do |config|
  config.name = 'QuickBooks Online'
  config.add_alias :qbo
  config.add_alias :quick_books_online
  config.module = 'QuickBooksOnline'
  config.rate_limiting_wait_in_seconds = 60
end
