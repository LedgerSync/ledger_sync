# frozen_string_literal: true

module LedgerSync
  module Adaptors
    class DashboardURLHelper
      attr_reader :resource,
                  :base_url

      def initialize(resource:, base_url:)
        @resource = resource
        @base_url = base_url
      end

      def url
        @base_url + resource_path
      end

      def resource_path
        raise NotImplementedError
      end
    end
  end
end
