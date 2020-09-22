# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Ledgers
    module Xero
      class Operation
        class Update
          include Xero::Operation::Mixin

          private

          def operate
            response_to_operation_result(
              response: client.post(
                path: ledger_resource_type_for_path,
                payload: [
                  serializer.serialize(resource: resource)
                ]
              )
            )
          end
        end
      end
    end
  end
end
