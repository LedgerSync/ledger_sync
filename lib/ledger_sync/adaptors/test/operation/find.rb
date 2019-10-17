# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Test
      module Operation
        class Find < Adaptors::Operation::Find
          private

          def operate
            return failure(nil) if resource.ledger_id.nil?

            response = adaptor.find(
              resource: resource.class.resource_type,
              id: resource.ledger_id
            )

            ledger_serializer = Test::LedgerSerializer.new(resource: resource)

            success(
              resource: ledger_serializer.deserialize(hash: response),
              response: response
            )
          end
        end
      end
    end
  end
end
