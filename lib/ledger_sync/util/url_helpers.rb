# frozen_string_literal: true

module LedgerSync
  module Util
    class URLHelpers
      def self.merge_params_in_url(args = {})
        params = args.fetch(:params)
        uri    = args.fetch(:url)

        uri = URI.parse(uri) unless uri.is_a?(URI::HTTPS) || uri.is_a?(URI::HTTP)
        uri.query = URI.encode_www_form(
          params.inject(URI.decode_www_form(String(uri.query))) { |prev, param| prev << param }
        )

        uri.to_s
      end

      def self.merge_params_in_path(args = {})
        params = args.fetch(:params)
        path   = args.fetch(:path)

        root, str_params = path.split('?')
        str_params = Rack::Utils.parse_nested_query(str_params)

        [
          root,
          Rack::Utils.build_query(str_params.merge(HashHelpers.deep_stringify_keys(params)))
        ].compact.join('?')
      end
    end
  end
end
