# frozen_string_literal: true

require_relative 'ledger_serializer_type/value'
Gem.find_files('ledger_sync/adaptors/ledger_serializer_type/**/*.rb').each { |path| require path }

module LedgerSync
  module Adaptors
    class LedgerSerializer
      attr_reader :resource

      def initialize(resource:)
        @resource = resource
        ensure_inferred_resource_class
      end

      # Do not overwrite values in the resource associated with this
      # serializer on initialization.
      def deserialize(hash)
        raise 'Hash expected' unless hash.is_a?(Hash)

        deserialize_into = Marshal.load(Marshal.dump(resource))

        hash = Util::HashHelpers.deep_stringify_keys(hash)

        self.class.attributes.each do |attribute_hash|
          resource_attribute = attribute_hash[:resource_attribute]
          next if resource_attribute.nil?

          ledger_attribute_parts = attribute_hash[:ledger_attribute].split('.')
          value = if ledger_attribute_parts.count == 1
                    hash[ledger_attribute_parts.first]
                  else
                    last_hash = hash.dig(*ledger_attribute_parts[0..-2])
                    next unless last_hash.is_a?(Hash)

                    last_hash[ledger_attribute_parts.last]
                  end

          value = attribute_hash[:type].new(
            attribute: resource_attribute.to_s.split('.').first,
            resource: resource,
            serializer: attribute_hash[:serializer],
            source: :ledger,
            value: value
          ).convert

          if resource_attribute.to_s.include?('.')
            deserialize_into = build_resource_value_from_nested_attributes(
              deserialize_into,
              value,
              resource_attribute.split('.')
            )
          else
            deserialize_into.send("#{resource_attribute}=", value)
          end
        end

        deserialize_into
      end

      def to_h(include_id: false)
        ret = {}

        self.class.attributes.each do |attribute_hash|
          resource_attribute = attribute_hash[:resource_attribute]

          next if !include_id && attribute_hash[:id]

          ledger_attribute_parts = attribute_hash[:ledger_attribute].split('.')
          value = if attribute_hash[:block].nil?
                    resource_dot_ret = resource
                    resource_attribute.to_s.split('.').each do |resource_attribute_part|
                      resource_dot_ret = resource_dot_ret.send(resource_attribute_part)
                      break if resource_dot_ret.nil?
                    end

                    resource_dot_ret
                  else
                    attribute_hash[:block].call(resource)
                  end
          value = attribute_hash[:type].new(
            attribute: resource_attribute.to_s.split('.').first,
            resource: resource,
            serializer: attribute_hash[:serializer],
            source: :local,
            value: value
          ).convert
          ret[ledger_attribute_parts.shift] = ledger_attribute_parts.reverse.inject(value) { |a, n| { n => a } }
        end

        ret
      end

      def self.attribute(ledger_attribute:, resource_attribute: nil, type: LedgerSerializerType::Value, &block)
        _attribute(
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute,
          type: type,
          &block
        )
      end

      def self.attributes
        @attributes ||= []
      end

      def self.references_many(ledger_attribute:, resource_attribute:, serializer:)
        _attribute(
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute,
          serializer: serializer,
          type: LedgerSerializerType::ReferencesMany
        )
      end

      def self.id(ledger_attribute:, resource_attribute:)
        @id ||= _attribute(
          id: true,
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute
        )
      end

      def self._inferred_resource_class
        parts = name.split('::')
        LedgerSync.const_get(parts[parts.index('Adaptors') + 2])
      end

      private_class_method def self._attribute(id: false, ledger_attribute:, resource_attribute: nil, serializer: nil, type: LedgerSerializerType::Value, &block)
        raise "ID has already been set for #{name}" if id && @id

        # TODO: Can make this validate something like `expense.vendor.id`
        # raise "#{resource_attribute} is not an attribute of the resource #{_inferred_resource_class}" if !resource_attribute.nil? && !_inferred_resource_class.serialize_attribute?(resource_attribute)

        attributes << {
          id: id,
          block: (block if block_given?),
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute,
          serializer: serializer,
          type: type
        }
      end

      private

      def build_resource_value_from_nested_attributes(resource, value, attributes)
        first_attribute, *remaining_attributes = attributes

        if remaining_attributes.count.zero?
          resource.public_send("#{first_attribute}=", value)
        else
          resource.public_send(
            "#{first_attribute}=",
            build_resource_value_from_nested_attributes(
              resource.public_send(first_attribute) || resource.class.resource_attributes[first_attribute.to_sym].type.resource_class.new,
              value,
              remaining_attributes
            )
          )
        end

        resource
      end

      def ensure_inferred_resource_class
        inferred_resource_class = self.class._inferred_resource_class
        raise "Resource must be a #{inferred_resource_class.name}.  Given #{resource.class}" unless resource.is_a?(inferred_resource_class)
      end
    end
  end
end
