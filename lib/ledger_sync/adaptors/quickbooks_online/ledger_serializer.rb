# frozen_string_literal: true

require 'ledger_sync/adaptors/ledger_serializer'

Gem.find_files('ledger_sync/adaptors/quickbooks_online/ledger_serializer_type/**/*.rb').each { |path| require path }

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      class LedgerSerializer < Adaptors::LedgerSerializer
        def deserialize(hash:, merge_for_full_update: false)
          deserialized_resource = super(hash: hash)
          return deserialized_resource unless merge_for_full_update

          merge_resources_for_full_update(
            hash: hash,
            ledger_resource: deserialized_resource
          )
        end

        def merge_resources_for_full_update(hash:, ledger_resource:)
          merged_resource = ledger_resource.dup

          self.class.attributes.each do |ledger_serializer_attribute|
            next unless ledger_serializer_attribute.references_many?

            resources_from_ledger = attribute_value_from_ledger(
              hash: hash,
              ledger_serializer_attribute: ledger_serializer_attribute,
              resource: merged_resource
            )

            resource_hash_from_ledger = Hash[resources_from_ledger.map { |e| [e.ledger_id, e] }]

            # Using original resource since it is overwritten by keyword arg
            merged_value = resource.send(ledger_serializer_attribute.resource_attribute_dot_parts.first).map do |referenced|
              if referenced.ledger_id.nil? # Assume creating a new resource in ledger
                referenced
              elsif resource_hash_from_ledger.key?(referenced.ledger_id.to_s) # Merged ledger into local
                ledger_resource = resource_hash_from_ledger[referenced.ledger_id.to_s]
                ledger_resource_serializer = ledger_serializer_attribute.serializer.new(resource: ledger_resource)
                ledger_serializer_attribute.serializer.new(resource: referenced).deserialize(hash: ledger_resource_serializer.to_h)
              end
              # Else assume delete from ledger
            end.compact

            merged_resource.assign_attribute(
              ledger_serializer_attribute.resource_attribute_dot_parts.first,
              merged_value
            )
          end

          merged_resource
        end

        # def to_h(only_changes: false)
        #   ret = super(only_changes: false)
        #   return ret unless only_changes

        #   ret.select do |k, _v|
        #     resource.attribute_changed?(k) || references_many_attribute_names.include?(k)
        #   end
        # end

        # private

        # def references_many_attribute_names
        #   @references_many_attribute_names ||= resource.resource_attributes.references_many.map(&:name)
        # end
      end
    end
  end
end
