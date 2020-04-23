# frozen_string_literal: true

require_relative 'attribute_set'

module LedgerSync
  class Serialization
    class DeserializerAttributeSet
      include AttributeSet::Mixin

      def assert_valid_to_add(attribute)
        raise 'resource_attribute is missing' unless attribute.resource_attribute.present?
        return unless resource_attribute_keyed_hash.key?(attribute.resource_attribute.to_s)

        raise "resource_attribute already defined for #{serializer_class.name}: #{attribute.resource_attribute}"
      end
    end
  end
end
