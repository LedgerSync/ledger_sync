# frozen_string_literal: true

require 'oauth2'

module LedgerSync
  module Ledgers
    module Stripe
      class Connection < Ledgers::Connection
        attr_reader :api_key

        def initialize(
          api_key:
        )
          @api_key = api_key
        end

        def url_for(resource:)
          DashboardURLHelper.new(
            resource: resource,
            base_url: "https://dashboard.stripe.com"
          ).url
        end

        def wrap_perform
          ::Stripe.api_key = api_key
          yield
        ensure
          ::Stripe.api_key = nil
        end

        def self.ledger_attributes_to_save
          []
        end
      end
    end
  end
end
