# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module NetSuiteREST
      module Operation
        class Create
          include NetSuiteREST::Operation::Mixin

          private

          def find_in_ledger
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
            find_in_ledger
              .and_then { success }
          end

          def response
            @response ||= adaptor.post(
              body: ledger_serializer.to_ledger_hash,
              path: ledger_serializer.class.api_resource_path
            )
          end
        end
      end
    end
  end
end
