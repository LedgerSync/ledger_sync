# frozen_string_literal: true

Gem.find_files('ledger_sync/serialization/type/**/*.rb').each { |path| require path }

module LedgerSync
  module Util
    class ResourceConverter
      class Attribute
        attr_reader :block,
                    :destination_attribute,
                    :source_attribute,
                    :type

        def initialize(args = {})
          @block                 = args.fetch(:block, nil)
          @destination_attribute = args.fetch(:destination_attribute, nil).to_s
          @source_attribute      = args.fetch(:source_attribute, destination_attribute).to_s
          @type                  = args.fetch(:type, nil) || LedgerSync::Type::Value.new

          return if block.blank?

          raise 'block and destination_attribute cannot both be present' if destination_attribute.present?
          raise 'block and source_attribute cannot both be present' if source_attribute.present?
        end

        def block_value_for(args = {})
          destination = args.fetch(:destination)
          source      = args.fetch(:source)

          block.call(
            {
              attribute: self,
              destination: destination,
              source: source
            }
          )
        end

        def build_destination_value_from_nested_attributes(args = {})
          destination = args.fetch(:destination).dup
          value       = args.fetch(:value)

          first_attribute, *remaining_attributes = args.fetch(:attribute_parts)

          if remaining_attributes.count.zero?
            destination.public_send("#{first_attribute}=", value)
          else
            next_destination = destination.public_send(first_attribute)
            next_destination ||= destination.class.destination_attributes[first_attribute.to_sym].type.resource_class.new
            destination.public_send(
              "#{first_attribute}=",
              build_destination_value_from_nested_attributes(
                destination: next_destination,
                value: value,
                attribute_parts: remaining_attributes
              )
            )
          end

          destination
        end

        def destination_attribute_class(destination:)
          @destination_attribute_type ||= {}
          @destination_attribute_type[destination] ||= destination.class.destination_attributes[destination_attribute_dot_parts.first.to_sym].type.resource_class
        end

        def destination_attribute_dot_parts
          @destination_attribute_dot_parts ||= destination_attribute.split('.')
        end

        def place_value_in_destination(destination:, value:)
          if destination.is_a?(Hash)
            destination_attribute_dot_parts.reverse.inject(value) { |a, n| { n => a } }
          else
            return value if destination_attribute_dot_parts.count <= 1

            nested_destination = destination.send(destination_attribute_dot_parts.first)
            nested_destination ||= destination_attribute_class(destination: destination).new

            build_destination_value_from_nested_attributes(
              destination: nested_destination,
              value: value,
              attribute_parts: destination_attribute_dot_parts[1..-1]
            )
          end
        end

        def reference?
          references_many? || references_one?
        end

        def source_attribute_dot_parts
          @source_attribute_dot_parts ||= source_attribute.split('.')
        end

        def value(source:)
          value = if source.is_a?(Hash)
                    source.dig(*source_attribute_dot_parts)
                  else
                    source_attribute_dot_parts.inject(source) { |r, dot_method| r&.send(dot_method) }
                  end

          type.cast(value: value)
        end
      end
    end
  end
end
