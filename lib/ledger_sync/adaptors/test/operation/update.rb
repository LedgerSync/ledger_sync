# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Test
      module Operation
        class Update < Adaptors::Operation::Update
          private

          def operate
            resource_type = resource.class.resource_type

            ledger_resource_data = adaptor.find(
              resource: resource_type,
              id: resource.ledger_id
            )

            find_serializer = Test::LedgerSerializer.new(resource: resource).deserialize(hash: ledger_resource_data)

            response = adaptor.post(
              resource: resource_type,
              payload: find_serializer.to_h
            )

            success(
              resource: Test::LedgerSerializer.new(resource: resource).deserialize(hash: response),
              response: response
            )
          end
        end
      end
    end
  end
end
