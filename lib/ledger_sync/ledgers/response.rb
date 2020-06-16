# frozen_string_literal: true

module LedgerSync
  module Ledgers
    class Response
      attr_reader :body,
                  :headers,
                  :raw,
                  :request,
                  :status

      def initialize(body: nil, headers: {}, raw: nil, request:, status:)
        @body = parse_json(body)
        @headers = headers
        @raw = raw
        @request = request
        @status = status
      end

      def failure?
        !success?
      end

      def success?
        (200..299).include?(status)
      end

      def self.new_from_faraday_response(faraday_response:, request:)
        new(
          body: faraday_response.body,
          headers: faraday_response.headers,
          raw: faraday_response,
          request: request,
          status: faraday_response.status
        )
      end

      def self.new_from_oauth_response(oauth_response:, request:)
        # Uses the same API
        new_from_faraday_response(
          faraday_response: oauth_response,
          request: request
        )
      end

      private

      def parse_json(json)
        return if json.nil?

        JSON.parse(json)
      rescue JSON::ParserError
        nil
      end
    end
  end
end
