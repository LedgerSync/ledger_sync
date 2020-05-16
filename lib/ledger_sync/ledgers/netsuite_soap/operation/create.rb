# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Ledgers
    module NetSuiteSOAP
      class Operation
        class Create
          include NetSuiteSOAP::Operation::Mixin

          private

          def operate
            response = client.post(
              resource: netsuite_online_resource_type,
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
