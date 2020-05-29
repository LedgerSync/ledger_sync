# frozen_string_literal: true

module LedgerSync
  module Ledgers
    class Request
      attr_reader :body,
                  :headers,
                  :method,
                  :params,
                  :response,
                  :url

      def initialize(body: nil, headers: {}, params: {}, method: nil, url: nil)
        @body = body
        @headers = headers
        @method = method
        @params = params
        @url = url
      end

      def perform
        raise 'Request already performed' if performed?

        url_with_params = Util::URLHelpers.merge_params_in_url(params: params, url: url)

        faraday_response = Faraday.send(method, url_with_params) do |req|
          req.headers = headers
          req.body = body.to_json unless body.nil?
        end

        @response = Response.new_from_faraday_response(faraday_response: faraday_response, request: self)
        @performed = true
        @response
      end

      def performed?
        @performed == true
      end

      def self.delete(**keywords)
        new(keywords.merge(method: :delete))
      end

      def self.get(**keywords)
        new(keywords.merge(method: :get))
      end

      def self.post(**keywords)
        new(keywords.merge(method: :post))
      end

      def self.put(**keywords)
        new(keywords.merge(method: :put))
      end

      def self.merge_params(args = {})
        params = args.fetch(:params)
        uri = args.fetch(:url)

        uri = URI.parse(uri) unless uri.is_a?(URI::HTTPS) || uri.is_a?(URI::HTTP)
        uri.query = URI.encode_www_form(
          params.inject(URI.decode_www_form(String(uri.query))) { |prev, param| prev << param }
        )
        uri.to_s
      end
    end
  end
end
