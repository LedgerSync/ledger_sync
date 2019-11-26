# frozen_string_literal: true

module NetSuiteRESTHelpers
  def netsuite_rest_adaptor
    adaptors.netsuite_rest.new(
      account_id: ENV.fetch('NETSUITE_REST_ACCOUNT_ID', 'account_id'),
      consumer_key: ENV.fetch('NETSUITE_REST_CONSUMER_KEY', 'consumer_key'),
      consumer_secret: ENV.fetch('NETSUITE_REST_CONSUMER_SECRET', 'consumer_secret'),
      token_id: ENV.fetch('NETSUITE_REST_TOKEN_ID', 'token_id'),
      token_secret: ENV.fetch('NETSUITE_REST_TOKEN_SECRET', 'token_secret')
    )
  end
end
