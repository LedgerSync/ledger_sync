# frozen_string_literal: true

module NetSuiteSOAPHelpers
  def env_account_id
    return ENV.fetch('NETSUITE_SOAP_ACCOUNT_ID', 'netsuite_account_id') if netsuite_env?

    'netsuite_account_id'
  end

  def env_api_version
    return ENV.fetch('NETSUITE_SOAP_API_VERSION', '2016_2') if netsuite_env?

    '2016_2'
  end

  def env_consumer_key
    return ENV.fetch('NETSUITE_SOAP_CONSUMER_KEY', 'NETSUITE_SOAP_CONSUMER_KEY') if netsuite_env?

    'NETSUITE_SOAP_CONSUMER_KEY'
  end

  def env_consumer_secret
    return ENV.fetch('NETSUITE_SOAP_CONSUMER_SECRET', 'NETSUITE_SOAP_CONSUMER_SECRET') if netsuite_env?

    'NETSUITE_SOAP_CONSUMER_SECRET'
  end

  def env_token_id
    return ENV.fetch('NETSUITE_SOAP_TOKEN_ID', 'NETSUITE_SOAP_TOKEN_ID') if netsuite_env?

    'NETSUITE_SOAP_TOKEN_ID'
  end

  def env_token_secret
    return ENV.fetch('NETSUITE_SOAP_TOKEN_SECRET', 'NETSUITE_SOAP_TOKEN_SECRET') if netsuite_env?

    'NETSUITE_SOAP_TOKEN_SECRET'
  end

  def netsuite_env?
    @netsuite_env ||= ENV.key?('USE_DOTENV_ADAPTOR_SECRETS')
  end

  def netsuite_soap_client(*args)
    LedgerSync.ledgers.netsuite_soap.new(**netsuite_client_args(*args))
  end

  def netsuite_client_args(**override)
    {
      account_id: env_account_id,
      api_version: env_api_version,
      consumer_key: env_consumer_key,
      consumer_secret: env_consumer_secret,
      token_id: env_token_id,
      token_secret: env_token_secret
    }.merge(override)
  end

  def stub_customer_find
    stub_request(:get, 'https://netsuite-account-id.suitetalk.api.netsuite.com/wsdl/v2016_2_0/netsuite.wsdl')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '', headers: {})
  end
end
