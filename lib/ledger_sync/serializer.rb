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

        ret = Util::HashHelpers.deep_merge(
          hash_to_merge_into: ret,
          other_hash: serializer_attribute.hash_attribute_hash_for(resource: resource)
        )
      end

      ret
    end

    def self.attribute(hash_attribute, args = {}, &block)
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
  end
end
