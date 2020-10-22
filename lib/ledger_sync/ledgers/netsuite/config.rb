# frozen_string_literal: true

require_relative 'client'

LedgerSync.register_ledger(:netsuite, base_module: LedgerSync::Ledgers::NetSuite) do |config|
  config.name = 'NetSuite REST'
end
