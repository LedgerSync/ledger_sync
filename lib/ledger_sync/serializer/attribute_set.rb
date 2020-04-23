# frozen_string_literal: true

module LedgerSync
  class Serializer
    class AttributeSet
      include Util::Mixins::DelegateArrayMethodsMixin

      attr_reader :attributes,
                  :id_attribute,
                  :output_attribute_keyed_hash,
                  :resource_attribute_keyed_hash,
                  :serializer_class

      delegate_array_methods_to :attributes

      def initialize(serializer_class:)
        @attributes = []
        @output_attribute_keyed_hash = {}
        @resource_attribute_keyed_hash = {}
        @serializer_class = serializer_class
      end

      def add(attribute)
        @attributes << attribute
        @id_attribute = attribute if attribute.id
        if attribute.output_attribute.present?
          raise "output_attribute already defined for #{serializer_class.name}: #{attribute.output_attribute}" if output_attribute_keyed_hash.key?(attribute.output_attribute.to_s)

          output_attribute_keyed_hash[attribute.output_attribute.to_s] = attribute
        end

        if attribute.resource_attribute.present?
          # raise "resource_attribute already defined for #{serializer_class.name}: #{attribute.resource_attribute}" if resource_attribute_keyed_hash.key?(attribute.resource_attribute.to_s)

          resource_attribute_keyed_hash[attribute.resource_attribute.to_s] = attribute
        end

        # TODO: Can make this validate something like `expense.vendor.id`
        # raise "#{resource_attribute} is not an attribute of the resource #{_inferred_resource_class}" if !resource_attribute.nil? && !_inferred_resource_class.serialize_attribute?(resource_attribute)

        attribute
      end

      def output_attribute?(key)
        output_attribute_keyed_hash.include?(key.to_s)
      end
    end
  end
end
