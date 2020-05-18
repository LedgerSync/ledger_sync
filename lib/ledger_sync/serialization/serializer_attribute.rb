# frozen_string_literal: true

require_relative 'attribute'

module LedgerSync
  module Serialization
    class SerializerAttribute < Attribute
      def initialize(args = {})
        super

        raise 'Missing hash_attribute' if hash_attribute.blank?

        if block.present?
          raise 'block and hash_attribute cannot both be present' if resource_attribute.present?
        else
          @resource_attribute ||= hash_attribute
        end
      end

      # Make nested/dot calls (e.g. `vendor.ledger_id`)
      def dot_value_for(resource:)
        resource_attribute_dot_parts.inject(resource) { |r, dot_method| r&.send(dot_method) }
      end

      def hash_attribute_hash_for(resource:)
        hash_attribute_hash_with(value: value(resource: resource))
      end

      # Create nested hash for ledger
      #
      # when hash_attribute = 'Foo.Bar.Baz',
      # hash_attribute_hash_with(value: 123)
      # Result:
      # {
      #   'Foo' => {
      #     'Bar' => {
      #       'Baz' => 123
      #     }
      #   }
      # }
      def hash_attribute_hash_with(value:)
        hash_attribute_dot_parts.reverse.inject(value) { |a, n| { n => a } }
      end

      def references_many?
        type.is_a?(Type::SerializerReferencesManyType)
      end

      def references_one?
        type.is_a?(Type::SerializerReferencesOneType)
      end

      def value(resource:)
        value = if block.nil?
                  dot_value_for(resource: resource)
                else
                  block_value_for(resource: resource)
                end

        type.cast(value: value)
      end
    end
  end
end
