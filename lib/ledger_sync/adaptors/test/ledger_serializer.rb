# frozen_string_literal: true

require 'ledger_sync/adaptors/ledger_serializer'

Gem.find_files('ledger_sync/adaptors/quickbooks_online/ledger_serializer_type/**/*.rb').each { |path| require path }

module LedgerSync
  module Adaptors
    module Test
      class LedgerSerializer < Adaptors::LedgerSerializer
        def initialize(resource:)
          @resource = resource
        end

        def deserialize(hash:)
          deserialized_resource = resource.dup

          hash.each do |key, value|
            key = key.to_s
            next unless deserialized_resource.respond_to?("#{key}=")

            resource_attribute = deserialized_resource.resource_attributes[key.to_sym]
            if resource_attribute&.references_many?
              type = LedgerSerializerType::ReferencesMany
              resource_class = resource_attribute.type.resource_class
            else
              type = LedgerSerializerType::Value
              resource_class = resource.class
            end

            ledger_serializer_attribute = LedgerSerializerAttribute.new(
              id: (key == 'id'),
              ledger_attribute: key,
              resource_attribute: key,
              resource_class: resource_class,
              serializer: self.class,
              type: type
            )

            value = attribute_value_from_ledger(
              hash: hash,
              ledger_serializer_attribute: ledger_serializer_attribute,
              resource: deserialized_resource
            )

            deserialized_resource.assign_attribute(
              ledger_serializer_attribute.resource_attribute_dot_parts.first,
              value
            )
          end

          deserialized_resource
        end

        def to_ledger_hash(only_changes: false)
          ret = resource.serializer.serialize[:objects].first.last[:data]
          return ret unless only_changes

          ret.select { |e| resource.changes.keys.include?(e.to_s) }
        end
      end
    end
  end
end
