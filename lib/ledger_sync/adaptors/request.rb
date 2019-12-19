# frozen_string_literal: true

module LedgerSync
  module Adaptors
    class Request
      attr_reader :body,
                  :headers,
                  :method,
                  :response,
                  :url

      def initialize(body: nil, headers: {}, method:, url:)
        @body = body
        @headers = headers
        @method = method
        @url = url
      end

      def perform
        raise 'Request already performed' if performed?

        faraday_response = Faraday.send(method, url) do |req|
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
    end
  end
end
