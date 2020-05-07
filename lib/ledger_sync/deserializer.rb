# frozen_string_literal: true

require_relative 'serialization/mixin'
require_relative 'serialization/deserializer_attribute_set'
require_relative 'serialization/deserializer_attribute'

module LedgerSync
  class Deserializer
    include Serialization::Mixin

    class Delegator
      def deserialize(args = {})
        deserializer_for(args).new.deserialize(args)
      end

      private

      def deserializer_for(_args = {})
        raise NotImplementedError
      end
    end

    def attribute_value_from_ledger(hash:, ledger_serializer_attribute:, resource:)
      ledger_serializer_attribute.value_from_hash(
        hash: hash,
        resource: resource
      )
    end

    def deserialize(args = {})
      hash     = args.fetch(:hash)
      resource = args.fetch(:resource)

      deserialize_into = resource.dup # Do not overwrite values in the resource
      hash = Util::HashHelpers.deep_stringify_keys(hash)

      self.class.attributes.each_value do |ledger_serializer_attribute|
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
      raise 'You cannot provide resource_attribute in args.  Pass the value as the first argument.' if args.key?(:resource_attribute)

      _attribute(
        args.merge(
          block: (block if block_given?),
          resource_attribute: resource_attribute
        )
      )
    end

    def self.attribute_class
      Serialization::DeserializerAttribute
    end

    def self.attributes
      @attributes ||= Serialization::DeserializerAttributeSet.new(serializer_class: self)
    end
  end
end

