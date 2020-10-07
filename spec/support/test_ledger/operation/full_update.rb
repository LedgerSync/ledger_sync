# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Ledgers
    module TestLedger
      class Operation
        class FullUpdate
          include TestLedger::Operation::Mixin

          private

          def find_resource
            client.find(
              path: ledger_resource_path
            )
          end

          def operate
            find_result_hash = find_resource.body[quickbooks_online_resource_type.to_s.classify]
            merged_resource = deserializer.deserialize(
              hash: find_result_hash,
              merge_for_full_update: true,
              resource: resource
            )
            merged_serializer = serializer.class.new
            response_to_operation_result(
              response: client.post(
                path: ledger_resource_type_for_path,
                payload: merged_serializer.serialize(
                  deep_merge_unmapped_values: find_result_hash,
                  resource: merged_resource
                )
              )
            )
          end
        end
      end
    end
  end
end
