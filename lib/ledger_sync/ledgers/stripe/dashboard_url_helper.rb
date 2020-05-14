# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Stripe
      class DashboardURLHelper < LedgerSync::Ledgers::DashboardURLHelper
        def resource_path
          @resource_path = case resource
                           when Stripe::Customer
                             "/customers/#{resource.ledger_id}"
                           else
                             raise Error::LedgerError::UnknownURLFormat.new(
                               client: self,
                               resource: resource
                             )
          end
        end
      end
    end
  end
end
