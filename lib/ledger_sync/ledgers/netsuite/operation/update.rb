# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Ledgers
    module NetSuite
      module Operation
        class Update
          include NetSuite::Operation::Mixin

          private

          def update_in_ledger
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

          def find
            resource.ledger_id = ledger_id

            self.class.operations_module::Find.new(
              client: client,
              resource: resource
            ).perform
          end

          def ledger_id
            @ledger_id ||= response.headers['Location'].split('/').last
          end

          def operate
            update_in_ledger
              .and_then { success }
          end

          def response
            @response ||= client.patch(
              body: serializer.serialize(resource: resource),
              path: ledger_resource_path
            )
          end

          def success
            find.and_then do |find_result|
              super(
                resource: find_result.resource,
                response: response
              )
            end
          end
        end
      end
    end
  end
end
