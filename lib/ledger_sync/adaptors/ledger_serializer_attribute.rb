# frozen_string_literal: true

require_relative 'ledger_serializer_type/value'
Gem.find_files('ledger_sync/adaptors/ledger_serializer_type/**/*.rb').each { |path| require path }

module LedgerSync
  module Adaptors
    class LedgerSerializerAttribute
      attr_reader :block,
                  :id,
                  :ledger_attribute,
                  :resource_attribute,
                  :resource_class,
                  :serializer,
                  :type

      def initialize(block: nil, id: false, ledger_attribute:, resource_attribute: nil, resource_class: nil, serializer: nil, type: LedgerSerializerType::Value)
        raise 'block and resource_attribute cannot both be present' unless block.nil? || resource_attribute.nil?

        @block = block
        @id = id
        @ledger_attribute = ledger_attribute.to_s
        @resource_attribute = resource_attribute.to_s
        @resource_class = resource_class
        @serializer = serializer
        @type = type.new
      end

      def block_value_for(resource:)
        block.call(resource)
      end

      # Make nested/dot calls (e.g. `vendor.ledger_id`)
      def dot_value_for(resource:)
        resource_attribute_dot_parts.inject(resource) { |r, dot_method| r&.send(dot_method) }
      end

      def ledger_attribute_dot_parts
        @ledger_attribute_dot_parts ||= ledger_attribute.split('.')
      end

      def ledger_attribute_hash_for(resource:)
        ledger_attribute_hash_with(value: value_from_local(resource: resource))
      end

      # Create nested hash for ledger
      #
      # when ledger_attribute = 'Foo.Bar.Baz',
      # ledger_attribute_hash_with(value: 123)
      # Result:
      # {
      #   'Foo' => {
      #     'Bar' => {
      #       'Baz' => 123
      #     }
      #   }
      # }
      def ledger_attribute_hash_with(value:)
        ledger_attribute_dot_parts.reverse.inject(value) { |a, n| { n => a } }
      end

      def references_many?
        type.is_a?(LedgerSerializerType::ReferencesMany)
      end

      def resource_attribute?
        resource_attribute.present?
      end

      def resource_attribute_dot_parts
        @resource_attribute_dot_parts ||= resource_attribute.split('.')
      end

      def value_from_local(resource:)
        value = if block.nil?
                  dot_value_for(resource: resource)
                else
                  block_value_for(resource: resource)
                end

        if references_many?
          type.convert_from_local(
            serializer: serializer,
            value: value
          )
        else
          type.convert_from_local(
            value: value
          )
        end
      end

      def value_from_ledger(hash:, resource:)
        value = hash.dig(*ledger_attribute_dot_parts)

        value = if references_many?
                  type.convert_from_ledger(
                    resource_class: resource_class,
                    serializer: serializer,
                    value: value
                  )
                else
                  type.convert_from_ledger(
                    value: value
                  )
                end

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
