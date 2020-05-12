# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Operation
        class Create
          include QuickBooksOnline::Operation::Mixin

          private

          def operate
            response_to_operation_result(
              response: connection.post(
                path: ledger_resource_type_for_path,
                payload: ledger_serializer.to_ledger_hash
              )
            )
          end
        end
      end
    end
  end
end
