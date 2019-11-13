# frozen_string_literal: true

module NetSuiteHelpers
  def netsuite_adaptor
    adaptors.netsuite.new(**netsuite_adaptor_args)
  end

  def netsuite_adaptor_args
    {
      account: 'account',
      consumer_key: 'consumer_key',
      consumer_secret: 'consumer_secret',
      token_id: 'token_id',
      token_secret: 'token_secret'
    }
  end
end
