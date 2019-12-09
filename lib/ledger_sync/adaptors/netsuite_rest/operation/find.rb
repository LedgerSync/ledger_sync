# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module NetSuiteREST
      module Operation
        class Find
          include NetSuiteREST::Operation::Mixin

          private

          def operate

            find_in_ledger.and_then do
              success(
                resource: ledger_serializer.deserialize(hash: response.body),
                response: response
              )
            end
          end

          private

          def find_in_ledger
            case response.status
            when 404
              failure(
                OperationErrors::NotFoundError.new(
                  operation: self,
                  response: response
                )
              )
            else
              LedgerSync::Result.Success(response)
            end
          end

          def response
            @response ||= adaptor.get(
              path: ledger_serializer.class.api_resource_path(resource: resource)
            )
          end
        end
      end
    end
  end
end
