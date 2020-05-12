# frozen_string_literal: true

LedgerSync.register_connection(:netsuite_soap, module_string: 'NetSuiteSOAP') do |config|
  config.name = 'NetSuite SOAP'
end
