# frozen_string_literal: true

LedgerSync.register_connection(:quickbooks_online, module_string: 'QuickBooksOnline') do |config|
  config.name = 'QuickBooks Online'
  config.add_alias :qbo
  config.add_alias :quick_books_online
  config.rate_limiting_wait_in_seconds = 60
end
