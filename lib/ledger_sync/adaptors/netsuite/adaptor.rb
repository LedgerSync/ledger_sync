require 'oauth2'

module LedgerSync
  module Adaptors
    module NetSuite
      class Adaptor < Adaptors::Adaptor
        DEFAULT_API_VERSION = '2018_2'.freeze

        attr_reader :account,
                    :application_idz,
                    :api_version,
                    :consumer_key,
                    :consumer_secret,
                    :token_id,
                    :token_secret

        def initialize(
          account:,
          application_id:,
          api_version: nil,
          consumer_key:,
          consumer_secret:,
          token_id:,
          token_secret:
        )
          @account = account
          @application_id = application_id
          @api_version = api_version || DEFAULT_API_VERSION
          @consumer_key = consumer_key
          @consumer_secret = consumer_secret
          @token_id = token_id
          @token_secret = token_secret
        end

        def setup
          setup_account = account
          # setup_application_id = application_id
          setup_api_version = api_version
          setup_consumer_key = consumer_key
          setup_consumer_secret = consumer_secret
          setup_token_id = token_id
          setup_token_secret = token_secret

          ::NetSuite.configure do
            reset!

            account setup_account
            consumer_key setup_consumer_key
            consumer_secret setup_consumer_secret
            token_id setup_token_id
            token_secret setup_token_secret
            api_version setup_api_version
            wsdl_domain "#{setup_account}.suitetalk.api.netsuite.com"
          end
        #   ::NetSuite::Configuration.soap_header = {
        #     'platformMsgs:ApplicationInfo' => {
        #        'platformMsgs:applicationId' => application_id
        #     }
        #  }
        end

        def teardown
          ::NetSuite.configure do
            reset!
          end
        end

        def self.ledger_attributes_to_save
          []
        end
      end
    end
  end
end
