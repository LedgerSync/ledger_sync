# frozen_string_literal: true

Gem.find_files('ledger_sync/serializer/type/**/*.rb').each { |path| require path }

module LedgerSync
  class Serializer
    class Attribute
      attr_reader :block,
                  :id,
                  :output_attribute,
                  :resource_attribute,
                  :resource_class,
                  :serializer,
                  :type

      def initialize(args = {})
        @block              = args.fetch(:block, nil)
        @id                 = args.fetch(:id, false)
        @output_attribute   = args.fetch(:output_attribute).try(:to_s)
        @resource_attribute = args.fetch(:resource_attribute, nil).try(:to_s)
        @resource_class     = args.fetch(:resource_class, nil)
        @serializer         = args.fetch(:serializer, nil)
        @type               = args.fetch(:type, nil) || Type::ValueType.new

        raise 'block and resource_attribute cannot both be present' unless block.nil? || resource_attribute.nil?
      end

      def block_value_for(resource:)
        block.call(resource)
      end

      def deserialize?
        deserialize
      end

      # Make nested/dot calls (e.g. `vendor.ledger_id`)
      def dot_value_for(resource:)
        resource_attribute_dot_parts.inject(resource) { |r, dot_method| r&.send(dot_method) }
      end

      def output_attribute_dot_parts
        @output_attribute_dot_parts ||= output_attribute.split('.')
      end

      def output_attribute_hash_for(resource:)
        output_attribute_hash_with(value: value_from_resource(resource: resource))
      end

      # Create nested hash for ledger
      #
      # when output_attribute = 'Foo.Bar.Baz',
      # output_attribute_hash_with(value: 123)
      # Result:
      # {
      #   'Foo' => {
      #     'Bar' => {
      #       'Baz' => 123
      #     }
      #   }
      # }
      def output_attribute_hash_with(value:)
        output_attribute_dot_parts.reverse.inject(value) { |a, n| { n => a } }
      end

      def reference?
        references_many? || references_one?
      end

      def references_many?
        type.is_a?(Type::ReferencesManyType)
      end

      def references_one?
        type.is_a?(Type::ReferencesOneType)
      end

      def resource_attribute?
        resource_attribute.present?
      end

      def resource_attribute_dot_parts
        @resource_attribute_dot_parts ||= resource_attribute.split('.')
      end

      def serialize?
        serialize
      end

      def value_from_resource(resource:)
        value = if block.nil?
                  dot_value_for(resource: resource)
                else
                  block_value_for(resource: resource)
                end

        type.convert(
          value: value
        )
      end

      def value_from_ledger(hash:, resource:)
        value = hash.dig(*output_attribute_dot_parts)

        value = if reference?
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
