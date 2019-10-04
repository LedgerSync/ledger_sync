# frozen_string_literal: true

module LedgerSync
  module Adaptors
    class Serializer
      attr_reader :resource

      def initialize(resource:)
        inferred_resource_class = self.class._inferred_resource_class
        raise "Resource must be a #{inferred_resource_class.name}" unless resource.is_a?(inferred_resource_class)

        @resource = resource
      end

      # Do not overwrite values in the resource associated with this
      # serializer on initialization.
      def deserialize(hash)
        _deserialize(hash, deserialize_into: Marshal.load(Marshal.dump(resource)))
      end

      def to_h(include_id: false)
        ret = {}

        self.class.attributes.each do |resource_attribute, attribute_hash|
          next if !include_id && attribute_hash[:id]

          ledger_attribute_parts = attribute_hash[:ledger_attribute].split('.')
          value = resource.send(resource_attribute)
          ret[ledger_attribute_parts.shift] = ledger_attribute_parts.reverse.inject(value) { |a, n| { n => a } }
        end

        ret
      end

      def self.attribute(id: false, ledger_attribute:, resource_attribute:)
        raise "ID has already been set for #{name}" if id && @id
        raise "#{resource_attribute} is not an attribute of the resource #{_inferred_resource_class}" unless _inferred_resource_class.serialize_attribute?(resource_attribute)

        attributes[resource_attribute] = {
          id: id,
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute
        }
      end

      def self.attributes
        @attributes ||= {}
      end

      def self.id(**keywords)
        @id ||= attribute(**keywords.merge(id: true))
      end

      def self._inferred_resource_class
        parts = name.split('::')
        LedgerSync.const_get(parts[parts.index('Adaptors') + 2])
      end

      private

      def _deserialize(hash, deserialize_into:)
        raise 'Hash expected' unless hash.is_a?(Hash)

        hash = Util::HashHelpers.deep_stringify_keys(hash)

        self.class.attributes.each do |resource_attribute, attribute_hash|
          ledger_attribute_parts = attribute_hash[:ledger_attribute].split('.')
          if ledger_attribute_parts.count == 1
            deserialize_into.send("#{resource_attribute}=", hash[ledger_attribute_parts.first])
          else
            last_hash = hash.dig(*ledger_attribute_parts[0..-2])
            next unless last_hash.is_a?(Hash)

            deserialize_into.send("#{resource_attribute}=", last_hash[ledger_attribute_parts.last])
          end
        end

        deserialize_into
      end
    end
  end
end
