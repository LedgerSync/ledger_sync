# frozen_string_literal: true

require 'oauth2'

module LedgerSync
  module Ledgers
    module NetSuite
      class Client < LedgerSync::Ledgers::Client
        HEADERS = {
          # 'Accept' => 'application/schema+json'
        }.freeze

        WRITE_HEADERS = {
          'Accept' => '*/*',
          'Content-Type' => 'application/json',
          'prefer' => 'transient'
        }.freeze

        attr_reader :account_id,
                    :consumer_key,
                    :consumer_secret,
                    :token_id,
                    :token_secret

        def initialize(
          account_id:,
          consumer_key:,
          consumer_secret:,
          token_id:,
          token_secret:
        )
          @account_id = account_id
          @consumer_key = consumer_key
          @consumer_secret = consumer_secret
          @token_id = token_id
          @token_secret = token_secret
        end

        def account_id_for_oauth
          account_id.split('-sb').join('_SB')
        end

        def account_id_for_url
          account_id.split('_SB').join('-sb')
        end

        def api_base_url
          @api_base_url ||= "https://#{api_host}/services/rest/record/v1"
        end

        def api_host
          @api_host ||= "#{account_id_for_url}.suitetalk.api.netsuite.com"
        end

        def delete(**keywords)
          request(keywords.merge(method: :delete))
        end

        def get(**keywords)
          request(keywords.merge(method: :get))
        end

        def ledger_resource_path(args = {})
          resource = args.fetch(:resource, nil)
          params   = args.fetch(:params, {})

          ret = self.class.ledger_resource_type_for(resource_class: resource.class) # This can be turned into a case statement if we need to override
          ret += "/#{resource.ledger_id}" if resource.ledger_id.present? && args.fetch(:id, true)
          Util::URLHelpers.merge_params_in_path(
            path: ret,
            params: params
          )
        end

        def metadata_for(record:)
          Record::Metadata.new(
            client: self,
            record: record
          )
        end

        def patch(headers: {}, **keywords)
          request(
            keywords.merge(
              headers: WRITE_HEADERS.merge(headers),
              method: :patch
            )
          )
        end

        def post(headers: {}, **keywords)
          request(
            keywords.merge(
              headers: WRITE_HEADERS.merge(headers),
              method: :post
            )
          )
        end

        def self.ledger_attributes_to_save
          %i[]
        end

        def self.new_from_env(**override)
          new(
            {
              account_id: ENV.fetch('NETSUITE_ACCOUNT_ID', nil),
              consumer_key: ENV.fetch('NETSUITE_CONSUMER_KEY', nil),
              consumer_secret: ENV.fetch('NETSUITE_CONSUMER_SECRET', nil),
              token_id: ENV.fetch('NETSUITE_TOKEN_ID', nil),
              token_secret: ENV.fetch('NETSUITE_TOKEN_SECRET', nil)
            }.merge(override)
          )
        end

        def url_for(resource:)
          DashboardURLHelper.new(
            resource: resource,
            base_url: "https://#{account_id_for_url}.app.netsuite.com"
          ).url
        end

        def self.ledger_resource_type_overrides
          {
            CustomerDeposit => 'customerdeposit',
            LedgerClass => 'classification',
            JournalEntry => 'journalEntry'
          }
        end

        private

        def new_token(args = {})
          Token.new(
            args.merge(
              consumer_key: consumer_key,
              consumer_secret: consumer_secret,
              token_id: token_id,
              token_secret: token_secret
            )
          )
        end

        def request(args = {})
          body        = args.fetch(:body, nil)
          headers     = args.fetch(:headers, {})
          method      = args.fetch(:method)
          path        = args.fetch(:path, nil)
          request_url = args.fetch(:request_url, url_from_path(path: path))

          raise request_url if request_url.include?('replace=line&expandSubResources=true')
          token = new_token(
            body: body,
            method: method,
            url: request_url
          )

          request = Request.new(
            body: body,
            headers: headers
              .merge(HEADERS)
              .merge(
                token.headers(
                  realm: account_id_for_oauth
                )
              )
              .merge(
                'Host' => api_host
              ),
            method: method,
            url: request_url
          )

          request.perform
        end

        def url_from_path(path:)
          request_url = api_base_url
          request_url += '/' unless path.to_s.start_with?('/')
          request_url + path.to_s
        end
      end
    end
  end
end
