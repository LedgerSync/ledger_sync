# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Department
        class Serializer < QuickBooksOnline::Serializer
          id

          attribute 'Name',
                    resource_attribute: :name
          attribute 'Active',
                    resource_attribute: :active
          attribute 'SubDepartment',
                    resource_attribute: :sub_department
          attribute 'FullyQualifiedName',
                    resource_attribute: :fully_qualified_name

          attribute(:ParentRef) do |args = {}|
            resource = args.fetch(:resource)

            if resource.parent.present?
              {
                'value' => resource.parent.ledger_id
              }
            end
          end

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
