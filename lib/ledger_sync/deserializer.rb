# frozen_string_literal: true

require_relative 'serializer/mixin'

module LedgerSync
  class Deserializer
    include Serializer::Mixin

    def attribute_value_from_ledger(hash:, ledger_serializer_attribute:, resource:)
      ledger_serializer_attribute.value_from_ledger(
        hash: hash,
        resource: resource
      )
    end

    def deserialize(args = {})
      hash     = args.fetch(:hash)
      resource = args.fetch(:resource)

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

    def self.attribute(resource_attribute, args = {}, &block)
      _attribute(
        args.merge(
          block: (block if block_given?),
          resource_attribute: resource_attribute
        )
      )
    end
  end
end

