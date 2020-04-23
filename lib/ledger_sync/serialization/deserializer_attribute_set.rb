# frozen_string_literal: true

require_relative 'attribute_set_mixin'

module LedgerSync
  class Serialization
    class DeserializerAttributeSet
      include AttributeSetMixin

      def add(attribute)
        raise 'resource_attribute is missing' unless attribute.resource_attribute.present?

        if attributes.key?(attribute.resource_attribute.to_s)
          raise "resource_attribute already defined for #{serializer_class.name}: #{attribute.resource_attribute}"
        end

        @attributes[attribute.resource_attribute] = attribute
        attribute
      end
    end
  end
end
