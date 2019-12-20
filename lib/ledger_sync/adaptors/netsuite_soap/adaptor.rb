require 'oauth2'

module LedgerSync
  module Adaptors
    module NetSuiteSOAP
      class Adaptor < Adaptors::Adaptor
        DEFAULT_API_VERSION = '2016_2'.freeze

        attr_reader :account_id,
                    :api_version,
                    :consumer_key,
                    :consumer_secret,
                    :account_id,
                    :token_id,
                    :token_secret

        def initialize(
          account_id:,
          api_version: nil,
          consumer_key:,
          consumer_secret:,
          token_id:,
          token_secret:
        )
          @account_id = account_id
          @api_version = api_version || DEFAULT_API_VERSION
          @consumer_key = consumer_key
          @consumer_secret = consumer_secret
          @token_id = token_id
          @token_secret = token_secret
        end

        #
        # Converts an account_id for use by the NetSuite gem
        #
        # @return [String] Converted account_id
        #
        def account_id_for_gem
          account_id.downcase.split('-sb').join('_SB')
        end

        #
        # Converts an account_id for use in the API URL
        #
        # @return [String] API URL compliant account_id
        #
        def account_id_for_url
          account_id.downcase.split('_SB').join('-sb')
        end

        def setup
          setup_account_id_for_gem = account_id_for_gem
          setup_account_id_for_url = account_id_for_url
          setup_api_version = api_version
          setup_consumer_key = consumer_key
          setup_consumer_secret = consumer_secret
          setup_token_id = token_id
          setup_token_secret = token_secret

          ::NetSuite.configure do
            reset!

            account setup_account_id_for_gem
            consumer_key setup_consumer_key
            consumer_secret setup_consumer_secret
            token_id setup_token_id
            token_secret setup_token_secret
            api_version setup_api_version
            wsdl_domain "#{setup_account_id_for_url}.suitetalk.api.netsuite.com"
          end
        end

        def teardown
          ::NetSuite.configure do
            reset!
          end
        end

        def wrap_perform
          setup
          yield
        ensure
          teardown
        end

        def self.ledger_attributes_to_save
          []
        end
      end
    end
  end
end
