# frozen_string_literal: true

require_relative 'attribute'

module LedgerSync
  class Serialization
    class DeserializerAttribute < Attribute
      def initialize(args = {})
        super

        raise 'Missing resource_attribute' if resource_attribute.blank?
        raise 'block and hash_attribute cannot both be present' unless block.nil? || hash_attribute.nil?
      end

      def value_from_hash(hash:, resource:)
        value = hash.dig(*hash_attribute.split('.'))

        value = type.convert(value: value)

        return value if resource_attribute_dot_parts.count <= 1

        nested_resource = resource.send(resource_attribute_dot_parts.first)
        nested_resource ||= resource_attribute_class(resource: resource).new

        build_resource_value_from_nested_attributes(
          nested_resource,
          value,
          resource_attribute_dot_parts[1..-1]
        )
      end

      private

      def build_resource_value_from_nested_attributes(resource, value, attribute_parts)
        resource = resource.dup
        first_attribute, *remaining_attributes = attribute_parts

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

      def resource_attribute_class(resource:)
        @resource_attribute_type ||= {}
        @resource_attribute_type[resource] ||= resource.class.resource_attributes[resource_attribute_dot_parts.first.to_sym].type.resource_class
      end
    end
  end
end
