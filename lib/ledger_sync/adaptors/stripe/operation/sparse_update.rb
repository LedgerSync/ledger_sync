# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module Stripe
      module Operation
        class SparseUpdate
          include Stripe::Operation::Mixin

          private

          def operate
            response = adaptor.post(
              resource: stripe_resource_type,
              payload: merged_serializer.to_ledger_hash
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
