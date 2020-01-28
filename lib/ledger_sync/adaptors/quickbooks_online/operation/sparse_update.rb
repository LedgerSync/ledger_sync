# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Operation
        class SparseUpdate
          include QuickBooksOnline::Operation::Mixin

          private

          def operate
            response = adaptor.post(
              resource: quickbooks_online_resource_type,
              payload: merged_serializer.to_ledger_hash
            )

            response_to_operation_result(
              resource: ledger_serializer.deserialize(hash: response),
              response: response
            )
          end
        end
      end
    end
  end
end
