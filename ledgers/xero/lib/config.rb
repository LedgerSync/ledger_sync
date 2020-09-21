# frozen_string_literal: true

LedgerSync.register_ledger(:xero, module_string: 'Xero') do |config|
  config.name = 'Xero'
end
