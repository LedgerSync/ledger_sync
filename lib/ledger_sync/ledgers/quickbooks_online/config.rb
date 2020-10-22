# frozen_string_literal: true

require_relative 'client'

LedgerSync.register_ledger(:quickbooks_online, base_module: LedgerSync::Ledgers::QuickBooksOnline) do |config|
  config.name = 'QuickBooks Online'
  config.add_alias :qbo
  config.add_alias :quick_books_online
  config.rate_limiting_wait_in_seconds = 60
end
