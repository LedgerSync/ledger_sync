# frozen_string_literal: true

require_relative 'serialization/mixin'
require_relative 'serialization/serializer_attribute_set'
require_relative 'serialization/serializer_attribute'

module LedgerSync
  class Serializer
    include Serialization::Mixin

    class Delegator
      def serialize(args = {})
        serializer_for(args).new.serialize(args)
      end

      private

      def serializer_for(_args = {})
        raise NotImplementedError
      end
    end

    def serialize(args = {})
      only_changes = args.fetch(:only_changes, false)
      resource     = args.fetch(:resource)

      ret = {}

      self.class.attributes.each_value do |serializer_attribute|
        next if only_changes && !resource.attribute_changed?(serializer_attribute.resource_attribute)
        next if serializer_attribute.if_method.present? && !send(serializer_attribute.if_method, resource: resource)

        ret = Util::HashHelpers.deep_merge(
          hash_to_merge_into: ret,
          other_hash: serializer_attribute.hash_attribute_hash_for(resource: resource)
        )
      end

      ret
    end

    def self.attribute(hash_attribute, args = {}, &block)
      if args.key?(:hash_attribute)
        raise 'You cannot provide hash_attribute in args.  Pass the value as the first argument.'
      end

      _attribute(
        args.merge(
          block: (block if block_given?),
          hash_attribute: hash_attribute
        )
      )
    end

    def self.attribute_class
      Serialization::SerializerAttribute
    end

    def self.attributes
      @attributes ||= Serialization::SerializerAttributeSet.new(serializer_class: self)
    end

    def self.references_one(hash_attribute, args = {}, &block)
      attribute(
        hash_attribute,
        {
          type: Serialization::Type::SerializerReferencesOneType.new(
            serializer: serializer_from(hash_attribute, args)
          )
        }.merge(args),
        &block
      )
    end

    def self.references_many(hash_attribute, args = {}, &block)
      attribute(
        hash_attribute,
        {
          type: Serialization::Type::SerializerReferencesManyType.new(
            serializer: serializer_from(hash_attribute, args)
          )
        }.merge(args),
        &block
      )
    end

    def self.serializer_from(hash_attribute, args = {})
      if args.key?(:serializer)
        args.fetch(:serializer)
      else
        resource_key = inferred_resource_class.resource_attributes[hash_attribute].type.resource_class.resource_type
        require File.join(inferred_config.root_path, resource_key.to_s, 'serializer')
        inferred_config.client_class.resources[resource_key]::Serializer
      end
    end
  end
end
