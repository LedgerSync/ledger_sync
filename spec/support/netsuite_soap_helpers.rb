# frozen_string_literal: true

module NetSuiteSOAPHelpers
  def netsuite_soap_client(*args)
    LedgerSync.ledgers.netsuite_soap.new(**netsuite_client_args(*args))
  end

  def netsuite_client_args(env: false, **override)
    env ||= ENV.key?('USE_DOTENV_ADAPTOR_SECRETS')
    {
      account_id: (env ? ENV.fetch('NETSUITE_SOAP_ACCOUNT_ID', 'netsuite_account_id') : 'netsuite_account_id'),
      api_version: (env ? ENV.fetch('NETSUITE_SOAP_API_VERSION', '2016_2') : '2016_2'),
      consumer_key: (env ? ENV.fetch('NETSUITE_SOAP_CONSUMER_KEY', 'NETSUITE_SOAP_CONSUMER_KEY') : 'NETSUITE_SOAP_CONSUMER_KEY'),
      consumer_secret: (env ? ENV.fetch('NETSUITE_SOAP_CONSUMER_SECRET', 'NETSUITE_SOAP_CONSUMER_SECRET') : 'NETSUITE_SOAP_CONSUMER_SECRET'),
      token_id: (env ? ENV.fetch('NETSUITE_SOAP_TOKEN_ID', 'NETSUITE_SOAP_TOKEN_ID') : 'NETSUITE_SOAP_TOKEN_ID'),
      token_secret: (env ? ENV.fetch('NETSUITE_SOAP_TOKEN_SECRET', 'NETSUITE_SOAP_TOKEN_SECRET') : 'NETSUITE_SOAP_TOKEN_SECRET')
    }.merge(override)
  end

  def stub_customer_find
    stub_request(:get, "https://netsuite_account_id.suitetalk.api.netsuite.com/wsdl/v2016_2_0/netsuite.wsdl").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "", headers: {})
  end
end
