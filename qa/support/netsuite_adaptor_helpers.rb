# frozen_string_literal: true

#
# Helper class for adaptors
#
module NetSuiteAdaptorHelpers
  def netsuite_adaptor
    @netsuite_adaptor ||= LedgerSync.adaptors.netsuite.new(
      account_id: ENV.fetch('NETSUITE_ACCOUNT_ID'),
      consumer_key: ENV.fetch('NETSUITE_CONSUMER_KEY'),
      consumer_secret: ENV.fetch('NETSUITE_CONSUMER_SECRET'),
      token_id: ENV.fetch('NETSUITE_TOKEN_ID'),
      token_secret: ENV.fetch('NETSUITE_TOKEN_SECRET')
    )
  end
end
