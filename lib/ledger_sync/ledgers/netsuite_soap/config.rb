# frozen_string_literal: true

require_relative 'client'

LedgerSync.register_ledger(:netsuite_soap, base_module: LedgerSync::Ledgers::NetSuiteSOAP) do |config|
  config.name = 'NetSuite SOAP'
end
