# frozen_string_literal: true

module LedgerSync
  module Adaptors
    class LedgerSerializerAttributeSet
      attr_reader :attributes,
                  :id_attribute,
                  :ledger_attribute_keyed_hash,
                  :resource_attribute_keyed_hash,
                  :serializer_class

      delegate  :[],
                :each,
                :include?,
                :map,
                to: :attributes

      def initialize(serializer_class:)
        @attributes = []
        @ledger_attribute_keyed_hash = {}
        @resource_attribute_keyed_hash = {}
        @serializer_class = serializer_class
      end

      def add(attribute)
        @attributes << attribute
        @id_attribute = attribute if attribute.id
        if attribute.ledger_attribute.present?
          raise "ledger_attribute already defined for #{serializer_class.name}: #{attribute.ledger_attribute}" if ledger_attribute_keyed_hash.key?(attribute.ledger_attribute.to_s)

          ledger_attribute_keyed_hash[attribute.ledger_attribute.to_s] = attribute
        end

        if attribute.resource_attribute.present?
          raise "resource_attribute already defined for #{serializer_class.name}: #{attribute.resource_attribute}" if resource_attribute_keyed_hash.key?(attribute.resource_attribute.to_s)

          resource_attribute_keyed_hash[attribute.resource_attribute.to_s] = attribute
        end

        # TODO: Can make this validate something like `expense.vendor.id`
        # raise "#{resource_attribute} is not an attribute of the resource #{_inferred_resource_class}" if !resource_attribute.nil? && !_inferred_resource_class.serialize_attribute?(resource_attribute)

        attribute
      end

      def ledger_attribute?(key)
        ledger_attribute_keyed_hash.include?(key.to_s)
      end
    end
  end
end
