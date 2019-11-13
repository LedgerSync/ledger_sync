# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module Stripe
      module Operation
        class Find
          include Stripe::Operation::Mixin

          private

          def operate
            return failure(nil) if resource.ledger_id.nil?

            response = adaptor.find(
              resource: stripe_resource_type,
              id: resource.ledger_id
            )

            success(
              resource: ledger_serializer.deserialize(hash: response),
              response: response
            )
          end
        end
      end
    end
  end
end
