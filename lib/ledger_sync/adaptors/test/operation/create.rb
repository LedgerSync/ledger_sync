# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Test
      module Operation
        class Create < Adaptors::Operation::Create
          private

          def operate
            ledger_serializer = Test::LedgerSerializer.new(resource: resource)

            response = adaptor.post(
              resource: resource.class.resource_type,
              payload: ledger_serializer.to_ledger_hash
            )

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
