# frozen_string_literal: true

require_relative '../operation'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Operation
        class FullUpdate
          include QuickBooksOnline::Operation::Mixin

          private

          def find_resource
            adaptor.find(
              path: ledger_resource_path
            )
          end

          def operate
            find_result_hash = find_resource.body.dig(
              quickbooks_online_resource_type.to_s.classify
            )
            merged_resource = ledger_serializer.deserialize(
              hash: find_result_hash,
              merge_for_full_update: true
            )
            merged_serializer = ledger_serializer.class.new(
              resource: merged_resource
            )

            pdb merged_serializer.to_ledger_hash(
              deep_merge_unmapped_values: find_result_hash
            )

            result(
              response: adaptor.post(
                path: ledger_resource_type_for_path,
                payload: merged_serializer.to_ledger_hash(
                  deep_merge_unmapped_values: find_result_hash
                )
              )
            )
          end
        end
      end
    end
  end
end
