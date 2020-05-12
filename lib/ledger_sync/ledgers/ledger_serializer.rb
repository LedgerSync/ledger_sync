# frozen_string_literal: true

require_relative 'ledger_serializer_type/value_type'
require_relative 'ledger_serializer_attribute'
require_relative 'ledger_serializer_attribute_set'
Gem.find_files('ledger_sync/ledgers/ledger_serializer_type/**/*.rb').each { |path| require path }

module LedgerSync
  module Ledgers
    class LedgerSerializer
      include Mixins::InferResourceClassMixin

      attr_reader :resource

      def initialize(**keywords)
        @resource = keywords.fetch(:resource)
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

        self.class.attributes.deserializable_attributes.each do |ledger_serializer_attribute|
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

        self.class.attributes.serializable_attributes.each do |ledger_serializer_attribute|
          next if only_changes && !resource.attribute_changed?(ledger_serializer_attribute.resource_attribute)

          ret = Util::HashHelpers.deep_merge(
            hash_to_merge_into: ret,
            other_hash: ledger_serializer_attribute.ledger_attribute_hash_for(resource: resource)
          )
        end

        ret
      end

      def self.attribute(
        deserialize: true,
        ledger_attribute:,
        resource_attribute: nil,
        serialize: true,
        type: LedgerSerializerType::ValueType,
        &block
      )
        _attribute(
          block: (block if block_given?),
          deserialize: deserialize,
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute,
          serialize: serialize,
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

      def self.references_one(ledger_attribute:, resource_attribute:, serializer:)
        _attribute(
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute,
          serializer: serializer,
          type: LedgerSerializerType::ReferencesOneType
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

      private_class_method def self._attribute(**keywords)
        attributes.add(
          _build_attribute(**keywords)
        )
      end

      private_class_method def self._build_attribute(
        block: nil,
        deserialize: true,
        id: false,
        ledger_attribute:,
        resource_attribute: nil,
        resource_class: nil,
        serialize: true,
        serializer: nil,
        type: LedgerSerializerType::ValueType
      )
        LedgerSerializerAttribute.new(
          id: id,
          block: block,
          deserialize: deserialize,
          ledger_attribute: ledger_attribute,
          resource_attribute: resource_attribute,
          resource_class: resource_class,
          serialize: serialize,
          serializer: serializer,
          type: type
        )
      end
    end
  end
end
