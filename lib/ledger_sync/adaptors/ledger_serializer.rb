# frozen_string_literal: true

require_relative 'ledger_serializer_type/value_type'
require_relative 'ledger_serializer_attribute'
require_relative 'ledger_serializer_attribute_set'
Gem.find_files('ledger_sync/adaptors/ledger_serializer_type/**/*.rb').each { |path| require path }

module LedgerSync
  module Adaptors
    class LedgerSerializer
      attr_reader :resource

      def initialize(resource:)
        @resource = resource
        ensure_inferred_resource_class!
      end

      def attribute_value_from_ledger(hash:, ledger_serializer_attribute:, resource:)
        ledger_serializer_attribute.value_from_ledger(
          hash: hash,
          resource: resource
        )
      end

      def deserialize(hash:)
        deserialize_into = resource.dup # Do not overwrite values in the resource
        hash = Util::HashHelpers.deep_stringify_keys(hash)

        self.class.attributes.each do |ledger_serializer_attribute|
          next unless ledger_serializer_attribute.resource_attribute?

          value = attribute_value_from_ledger(
            hash: hash,
            ledger_serializer_attribute: ledger_serializer_attribute,
            resource: deserialize_into
          )

          deserialize_into.assign_attribute(
            ledger_serializer_attribute.resource_attribute_dot_parts.first,
            value
          )
        end

        deserialize_into
      end

      def to_ledger_hash(only_changes: false)
        ret = {}

        self.class.attributes.each do |ledger_serializer_attribute|
          next if only_changes && !resource.attribute_changed?(ledger_serializer_attribute.resource_attribute)

          ret = Util::HashHelpers.deep_merge(
            hash_to_merge_into: ret,
            other_hash: ledger_serializer_attribute.ledger_attribute_hash_for(resource: resource)
          )
        end

        ret
      end

      def self.attribute(ledger_attribute:, resource_attribute: nil, type: LedgerSerializerType::ValueType, &block)
        _attribute(
          block: (block if block_given?),
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute,
          type: type
        )
      end

      def self.attributes
        @attributes ||= LedgerSerializerAttributeSet.new(serializer_class: self)
      end

      def self.references_many(ledger_attribute:, resource_attribute:, serializer:)
        _attribute(
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute,
          serializer: serializer,
          type: LedgerSerializerType::ReferencesManyType
        )
      end

      def self.id(ledger_attribute:, resource_attribute:, &block)
        @id ||= _attribute(
          block: (block if block_given?),
          id: true,
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute
        )
      end

      def self._inferred_resource_class
        parts = name.split('::')
        LedgerSync.const_get(parts[parts.index('Adaptors') + 2])
      end

      private_class_method def self._attribute(**keywords)
        attributes.add(
          _build_attribute(**keywords)
        )
      end

      private_class_method def self._build_attribute(block: nil, id: false, ledger_attribute:, resource_attribute: nil, resource_class: nil, serializer: nil, type: LedgerSerializerType::ValueType)
        LedgerSerializerAttribute.new(
          id: id,
          block: block,
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute,
          resource_class: resource_class,
          serializer: serializer,
          type: type
        )
      end

      private

      def ensure_inferred_resource_class!
        inferred_resource_class = self.class._inferred_resource_class
        raise "Resource must be a #{inferred_resource_class.name}.  Given #{resource.class}" unless resource.is_a?(inferred_resource_class)
      end
    end
  end
end
