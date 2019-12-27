# frozen_string_literal: true

require 'oauth2'

module LedgerSync
  module Adaptors
    module Stripe
      class Adaptor < LedgerSync::Adaptors::Adaptor
        attr_reader :api_key

        def initialize(
          api_key:
        )
          @api_key = api_key
        end

        def url_for(resource:)
          base_url = 'https://dashboard.stripe.com'
          resource_path = case resource
                          when LedgerSync::Customer
                            "/customers/#{resource.ledger_id}"
                          end

          base_url + resource_path
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
