# frozen_string_literal: true

require_relative 'attribute_set_mixin'

module LedgerSync
  class Serialization
    class SerializerAttributeSet
      include AttributeSetMixin

      def add(attribute)
        raise 'hash_attribute is missing' unless attribute.hash_attribute.present?

        if attributes.key?(attribute.hash_attribute.to_s)
          raise "hash_attribute already defined for #{serializer_class.name}: #{attribute.hash_attribute}"
        end

        @attributes[attribute.hash_attribute] = attribute
        attribute
      end
    end
  end
end
