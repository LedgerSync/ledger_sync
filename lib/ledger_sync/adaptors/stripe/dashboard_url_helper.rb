# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Stripe
      class DashboardURLHelper < LedgerSync::Adaptors::DashboardURLHelper
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
