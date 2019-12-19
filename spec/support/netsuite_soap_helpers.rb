# frozen_string_literal: true

module NetSuiteSOAPHelpers
  def netsuite_soap_adaptor
    LedgerSync.adaptors.netsuite_soap.new(**netsuite_adaptor_args)
  end

  def netsuite_adaptor_args(**override)
    {
      account_id: ENV.fetch('NETSUITE_ACCOUNT_ID', 'netsuite_account_id'),
      api_version: ENV.fetch('NETSUITE_API_VERSION', '2016_2'),
      consumer_key: ENV.fetch('NETSUITE_CONSUMER_KEY', 'NETSUITE_CONSUMER_KEY'),
      consumer_secret: ENV.fetch('NETSUITE_CONSUMER_SECRET', 'NETSUITE_CONSUMER_SECRET'),
      token_id: ENV.fetch('NETSUITE_TOKEN_ID', 'NETSUITE_TOKEN_ID'),
      token_secret: ENV.fetch('NETSUITE_TOKEN_SECRET', 'NETSUITE_TOKEN_SECRET')
    }.merge(override)
  end
end
