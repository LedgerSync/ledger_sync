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

        attr_reader :body,
                    :consumer_key,
                    :consumer_secret,
                    :method,
                    :token_id,
                    :token_secret,
                    :url

        def initialize(body: {}, consumer_key:, consumer_secret:, method:, nonce: nil, timestamp: nil, token_id:, token_secret:, url:)
          @body = body || {}
          @consumer_key = consumer_key
          @consumer_secret = consumer_secret
          @method = method.to_s.upcase
          @nonce = nonce
          @timestamp = timestamp
          @token_id = token_id
          @token_secret = token_secret
          @url = url
        end

        def alphanumerics
          [*'0'..'9', *'A'..'Z', *'a'..'z']
        end

        def headers(realm:)
          @headers ||= begin
            authorization_parts = [
              [:realm, escape(realm)],
              [:oauth_consumer_key, escape(consumer_key)],
              [:oauth_token, escape(token_id)],
              [:oauth_signature_method, SIGNATURE_METHOD],
              [:oauth_signature, escape(signature)],
              [:oauth_timestamp, timestamp],
              [:oauth_nonce, escape(nonce)],
              [:oauth_version, OAUTH_VERSION]
            ]

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

        # Ref: https://tools.ietf.org/html/rfc5849#section-3.4.1.3.2
        def signature_data_string
          @signature_data_string ||= begin
            data_string = escape(parameters_string)

            [
              method,
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
          CGI.escape(val.to_s).gsub(/\+/, '%20')
        end

        def parameters_string
          @parameters_string ||= sorted_encoded_parameters
                                 .map { |e| "#{e[0]}=#{e[1]}" }
                                 .join('&')
        end

        def sorted_encoded_parameters
          @sorted_encoded_parameters ||= body
                                         .to_a
                                         .concat(
                                           url_params.to_a
                                         )
                                         .concat(
                                           {
                                             oauth_consumer_key: consumer_key,
                                             oauth_nonce: nonce,
                                             oauth_signature_method: SIGNATURE_METHOD,
                                             oauth_timestamp: timestamp,
                                             oauth_token: token_id,
                                             oauth_version: OAUTH_VERSION
                                           }.to_a
                                         )
                                         .map { |k, v| [escape(k), escape(v)] }
                                         .sort { |a, b| a <=> b }
        end

        def unescape(val)
          CGI.unescape(val.to_s)
        end

        def uri
          @uri ||= URI(url)
        end

        def url_params
          return {} if uri.query.nil?

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
