# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module NetSuiteREST
      module Operation
        class Create
          include NetSuiteREST::Operation::Mixin

          private

          def operate
            response = adaptor.post(
              resource: netsuite_rest_resource_type,
              payload: ledger_serializer.to_ledger_hash
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
