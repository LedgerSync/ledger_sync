# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module NetSuite
      module Operation
        class Delete
          include NetSuite::Operation::Mixin

          private

          def delete
            case response.status
            when 200..299
              LedgerSync::Result.Success(response)
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
            delete
              .and_then { success }
          end

          def response
            @response ||= adaptor.delete(
              path: ledger_serializer.class.api_resource_path(resource: resource)
            )
          end

          def success
            super(
              resource: resource,
              response: response
            )
          end
        end
      end
    end
  end
end
