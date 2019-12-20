# frozen_string_literal: true

LedgerSync.register_adaptor(:netsuite_soap, module_string: 'NetSuiteSOAP') do |config|
  config.name = 'NetSuite SOAP'
end
