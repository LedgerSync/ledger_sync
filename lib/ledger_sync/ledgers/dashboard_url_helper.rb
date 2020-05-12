# frozen_string_literal: true

module LedgerSync
  module Ledgers
    class DashboardURLHelper
      attr_reader :resource,
                  :base_url

      def initialize(args = {})
        @resource = args.fetch(:resource)
        @base_url = args.fetch(:base_url)
      end

      def url
        File.join(base_url, resource_path)
      end

      def resource_path
        raise NotImplementedError
      end
    end
  end
end
