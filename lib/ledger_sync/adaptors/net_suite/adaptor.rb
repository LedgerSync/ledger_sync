require 'oauth2'

module LedgerSync
  module Adaptors
    module NetSuite
      class Adaptor < Adaptors::Adaptor
        attr_reader :account,
                    :consumer_key,
                    :consumer_secret,
                    :token_id,
                    :token_secret

        def initialize(
          account:,
          api_version: '2018_2',
          consumer_key:,
          consumer_secret:,
          token_id:,
          token_secret:
        )
          @account = account
          @consumer_key = consumer_key
          @consumer_secret = consumer_secret
          @token_id = token_id
          @token_secret = token_secret
        end

        private

        def setup
          NetSuite.configure do
            reset!

            account @account
            consumer_key @consumer_key
            consumer_secret @consumer_secret
            token_id @token_id
            token_secret @token_secret
            api_version '2016_2'
            wsdl_domain "#{@account}.suitetalk.api.netsuite.com"
          end
        end
      end
    end
  end
end
