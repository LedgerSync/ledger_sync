# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Ledgers
    module NetSuite
      module Operation
        class Find
          include NetSuite::Operation::Mixin

          private

          def find_in_ledger
            case response.status
            when 200
              LedgerSync::Result.Success(response)
            when 404
              failure(
                Error::OperationError::NotFoundError.new(
                  operation: self,
                  response: response
                )
              )
            else
              failure(
                Error::OperationError.new(
                  operation: self,
                  response: response
                )
              )
            end
          end

          def operate
            find_in_ledger
              .and_then { success }
          end

          def response
            @response ||= connection.get(
              path: ledger_resource_path
            )
          end

          def success
            super(
              resource: deserializer.deserialize(hash: response.body, resource: resource),
              response: response
            )
          end
        end
      end
    end
  end
end
