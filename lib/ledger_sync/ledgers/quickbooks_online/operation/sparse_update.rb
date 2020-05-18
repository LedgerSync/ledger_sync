# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Operation
        class SparseUpdate
          include QuickBooksOnline::Operation::Mixin

          private

          def operate
            response = client.post(
              resource: quickbooks_online_resource_type,
              payload: merged_serializer.serialize
            )

            response_to_operation_result(
              resource: serializer.deserialize(hash: response),
              response: response
            )
          end
        end
      end
    end
  end
end
