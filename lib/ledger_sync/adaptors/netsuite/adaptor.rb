require 'oauth2'

module LedgerSync
  module Adaptors
    module NetSuite
      class Adaptor < Adaptors::Adaptor
        DEFAULT_API_VERSION = '2018_2'.freeze

        attr_reader :account,
                    :application_id,
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
          ::NetSuite.configure do
            reset!

            account @account
            consumer_key @consumer_key
            consumer_secret @consumer_secret
            token_id @token_id
            token_secret @token_secret
            api_version '2016_2'
            wsdl_domain "#{@account}.suitetalk.api.netsuite.com"
          end
          ::NetSuite::Configuration.soap_header = {
            'platformMsgs:ApplicationInfo' => {
               'platformMsgs:applicationId' => application_id
            }
         }
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
