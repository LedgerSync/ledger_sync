# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module NetSuiteREST
      module Operation
        class Find
          include NetSuiteREST::Operation::Mixin

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
            @response ||= adaptor.get(
              path: ledger_serializer.class.api_resource_path(resource: resource)
            )
          end

          def success
            super(
              resource: ledger_deserializer.deserialize(hash: response.body),
              response: response
            )
          end
        end
      end
    end
  end
end
