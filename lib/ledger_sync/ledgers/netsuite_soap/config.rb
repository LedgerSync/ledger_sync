# frozen_string_literal: true

LedgerSync.register_client(:netsuite_soap, module_string: 'NetSuiteSOAP') do |config|
  config.name = 'NetSuite SOAP'
end
