# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Department
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute :Name
          attribute :Active
          attribute :SubDepartment
          attribute :FullyQualifiedName

          references_one 'ParentRef',
                         resource_attribute: :Parent,
                         serializer: Reference::Serializer

          # Sending "ParentRef": {"value": null} results in QBO API crash
          # This patches serialized hash to exclude it unless we don't set value
          def serialize(args = {})
            deep_merge_unmapped_values = args.fetch(:deep_merge_unmapped_values, {})
            only_changes = args.fetch(:only_changes, false)
            resource = args.fetch(:resource)

            ret = super(only_changes: only_changes, resource: resource)

            return ret unless deep_merge_unmapped_values.any?

            deep_merge_if_not_mapped(
              current_hash: ret,
              hash_to_search: deep_merge_unmapped_values
            )
          end
        end
      end
    end
  end
end
