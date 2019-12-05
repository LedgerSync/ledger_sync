# frozen_string_literal: true

# ref: https://docs.oracle.com/cloud/latest/netsuitecs_gs/NSATH/NSATH.pdf
# ref: Search "The Signature for Web Services and RESTlets" in NetSuite documentation (must have an account)
module LedgerSync
  module Adaptors
    module NetSuiteREST
      class Token
        DIGEST = OpenSSL::Digest.new('sha256')
        OAUTH_VERSION = '1.0'
        SIGNATURE_METHOD = 'HMAC-SHA256'

        attr_reader :account_id,
                    :consumer_key,
                    :consumer_secret,
                    :http_method,
                    :token_id,
                    :token_secret,
                    :url

        def initialize(account_id:, consumer_key:, consumer_secret:, http_method:, nonce: nil, timestamp: nil, token_id:, token_secret:, url:)
          @account_id = account_id.to_s
          @consumer_key = consumer_key
          @consumer_secret = consumer_secret
          @http_method = http_method.to_s.upcase
          @nonce = nonce
          @timestamp = timestamp
          @token_id = token_id
          @token_secret = token_secret
          @url = url
        end

        def alphanumerics
          [*'0'..'9', *'A'..'Z', *'a'..'z']
        end

        def headers
          @headers ||= begin
            authorization_parts = [
              [:realm, account_id],
              [:oauth_consumer_key, consumer_key],
              [:oauth_token, token_id],
              [:oauth_signature_method, SIGNATURE_METHOD],
              [:oauth_signature, signature],
              [:oauth_timestamp, timestamp],
              [:oauth_nonce, nonce],
              [:oauth_version, OAUTH_VERSION]
            ]

            pdb "OAuth #{authorization_parts.map { |k, v| "#{k}=\"#{v}\"" }.join(',')}"
            {
              'Authorization' => "OAuth #{authorization_parts.map { |k, v| "#{k}=\"#{v}\"" }.join(',')}"
            }
          end
        end

        def nonce
          @nonce ||= Array.new(20) { alphanumerics.sample }.join
        end

        def signature
          @signature ||= Base64.encode64(OpenSSL::HMAC.digest(DIGEST, signature_key, signature_data_string)).strip
        end

        def signature_data_string
          @signature_data_string ||= begin
            data_string = escape(
              url_params.merge(
                oauth_consumer_key: consumer_key,
                oauth_nonce: nonce,
                oauth_signature_method: SIGNATURE_METHOD,
                oauth_timestamp: timestamp,
                oauth_token: token_id,
                oauth_version: OAUTH_VERSION
              ).map { |k, v| [k, escape(v)].join('=') }.sort.join('&')
            )

            [
              http_method,
              escape(url_without_params),
              data_string
            ].join('&')
          end
        end

        def signature_key
          @signature_key ||= [
            consumer_secret,
            token_secret
          ].join('&')
        end

        def timestamp
          @timestamp ||= Time.now.to_i
        end

        private

        def escape(val)
          CGI.escape(val.to_s)
        end

        def uri
          @uri ||= URI(url)
        end

        def url_params
          @url_params ||= Hash[CGI.parse(uri.query).map { |k, v| [k, v.first] }]
        end

        def url_without_params
          @url_without_params ||= begin
            temp_url = uri.dup
            temp_url.fragment = nil
            temp_url.query = nil
            temp_url.to_s
          end
        end
      end
    end
  end
end
