# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Operation
        class Find
          include QuickBooksOnline::Operation::Mixin

          private

          def operate
            # return failure(
            #   Error::OperationError::LedgerIDRequired.new(
            #     operation: self
            #   )
            # ) if resource.ledger_id.nil?

            response_to_operation_result(
              response: adaptor.find(
                path: ledger_resource_path
              )
            )
          end
        end
      end
    end
  end
end
