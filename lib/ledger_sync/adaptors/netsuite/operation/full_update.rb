# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module NetSuite
      module Operation
        class FullUpdate
          include NetSuite::Operation::Mixin

          private

          def find_resource
            adaptor.find(
              resource: netsuite_online_resource_type,
              id: resource.ledger_id
            )
          end

          def operate
            update_resource(find_resource)
          end

          def update_resource(find_result_hash)
            merged_resource = ledger_serializer.deserialize(hash: find_result_hash, merge_for_full_update: true)
            merged_serializer = ledger_serializer.class.new(resource: merged_resource)

            response = adaptor.post(
              resource: netsuite_online_resource_type,
              payload: merged_serializer.to_ledger_hash(deep_merge_unmapped_values: find_result_hash)
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
