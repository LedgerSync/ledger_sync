# frozen_string_literal: true

Gem.find_files('ledger_sync/serialization/type/**/*.rb').each { |path| require path }

module LedgerSync
  module Util
    class ResourceConverter
      class Attribute
        attr_reader :block,
                    :destination_attribute,
                    :if_method,
                    :source_attribute,
                    :type

        def initialize(args = {})
          @block                 = args.fetch(:block, nil)
          @destination_attribute = args.fetch(:destination_attribute, nil).to_s
          @source_attribute      = args.fetch(:source_attribute, destination_attribute).to_s
          @type                  = args.fetch(:type, nil) || LedgerSync::Type::Value.new
          @if_method             = args.fetch(:if, nil)

          return if block.blank?

          raise 'block cannot be provided on references' if reference?
          raise 'block and destination_attribute cannot both be present' if destination_attribute.present?
          raise 'block and source_attribute cannot both be present' if source_attribute.present?
        end

        def block?
          block.present?
        end

        def block_value_for(args = {})
          destination = args.fetch(:destination).dup
          source      = args.fetch(:source).dup

          new_destination = block.call(
            {
              attribute: self,
              destination: destination,
              source: source
            }
          )

          return new_destination if destination.class == new_destination.class

          raise "Block value must be the same class as the destination: #{destination.class}"
        end

        def build_destination!(args = {})
          destination = args.fetch(:destination)
          destination = Util::HashHelpers.deep_stringify_keys(destination) if destination.is_a?(Hash)
          source      = args.fetch(:source).dup
          source      = Util::HashHelpers.deep_stringify_keys(source) if source.is_a?(Hash)

          if block?
            return block_value_for(
              destination: destination,
              source: source
            )
          end

          value = value(destination: destination, source: source)

          if destination.is_a?(Hash)
            destination = Util::HashHelpers.deep_merge(
              hash_to_merge_into: destination,
              other_hash: destination_attribute_dot_parts.reverse.inject(value) { |a, n| { n => a } }
            )
          else
            destination.assign_attribute(
              destination_attribute_dot_parts.first,
              value
            )
          end

          destination
        end

        def destination_attribute_class(destination:)
          @destination_attribute_type ||= {}
          @destination_attribute_type[destination] ||= destination.class.destination_attributes[
            destination_attribute_dot_parts.first.to_sym
          ].type.resource_class
        end

        def destination_attribute_dot_parts
          @destination_attribute_dot_parts ||= destination_attribute.split('.')
        end

        def reference?
          references_many? || references_one?
        end

        def references_one?
          type.is_a?(Type::ReferencesOneType)
        end

        def references_many?
          type.is_a?(Type::ReferencesManyType)
        end

        def reference_resource_converter
          @reference_resource_converter ||= type.resource_converter
        end

        def source_attribute_dot_parts
          @source_attribute_dot_parts ||= source_attribute.split('.')
        end

        def value(destination:, source:)
          value = if source.is_a?(Hash)
                    source.dig(*source_attribute_dot_parts)
                  else
                    source_attribute_dot_parts.inject(source) { |r, dot_method| r&.send(dot_method) }
                  end

          return type.cast(value: value) unless reference?

          destination_attribute_first_dot_part = destination_attribute_dot_parts.first
          new_destination = if destination.is_a?(Hash)
                              {}
                            else
                              destination.class.resource_attributes.fetch(
                                destination_attribute_first_dot_part.to_sym
                              ).type.resource_class.new
                            end
          type.cast(destination: new_destination, source: source, value: value)
        end
      end
    end
  end
end
