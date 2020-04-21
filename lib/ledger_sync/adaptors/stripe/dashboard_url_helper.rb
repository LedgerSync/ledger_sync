# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Stripe
      class DashboardURLHelper
        attr_reader :resource

        def initialize(resource:)
          @resource = resource
        end

        def base_url
          'https://dashboard.stripe.com'
        end

        def url
          base_url + resource_path
        end

        def resource_path
          @resource_path = case resource
          when LedgerSync::Customer
            "/customers/#{resource.ledger_id}"
          else
            raise Error::AdaptorError::UnknownURLFormat.new(
              adaptor: self,
              resource: resource
            )
          end
        end
      end
    end
  end
end
