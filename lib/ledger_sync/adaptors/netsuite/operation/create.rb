# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module NetSuite
      module Operation
        class Create
          include NetSuite::Operation::Mixin

          private

          def create_in_ledger
            return LedgerSync::Result.Success(response) if response.success?

            failure(
              Error::OperationError.new(
                operation: self,
                response: response
              )
            )
          end

          def find
            resource.ledger_id = ledger_id

            self.class.operations_module::Find.new(
              adaptor: adaptor,
              resource: resource
            ).perform
          end

          def ledger_id
            @ledger_id ||= response.headers['Location'].split('/').last
          end

          def operate
            create_in_ledger
              .and_then { success }
          end

          def response
            ledger_hash = ledger_serializer.to_ledger_hash
            ledger_hash.delete('entityId')

            @response ||= adaptor.post(
              body: ledger_hash,
              path: adaptor.api_resource_path
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
