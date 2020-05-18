# frozen_string_literal: true

require_relative 'resource_converter/attribute_set'
require_relative 'resource_converter/attribute'

module LedgerSync
  module Util
    class ResourceConverter
      def convert(args = {})
        destination  = args.fetch(:destination).dup
        only_changes = args.fetch(:only_changes, false)
        source       = args.fetch(:source).dup

        if source.is_a?(Hash) && args.key?(:only_changes)
          raise 'only_changes can only be passed when the source is a resource'
        end

        destination = Util::HashHelpers.deep_stringify_keys(destination) if destination.is_a?(Hash)
        source      = Util::HashHelpers.deep_stringify_keys(source) if source.is_a?(Hash)

        self.class.attributes.each_value do |converter_attribute|
          next if only_changes && !source.attribute_changed?(converter_attribute.source_attribute)

          value = converter_attribute.value(source: source)

          if destination.is_a?(Hash)
            destination = Util::HashHelpers.deep_merge(
              hash_to_merge_into: destination,
              other_hash: converter_attribute.destination_attribute_dot_parts.reverse.inject(value) { |a, n| { n => a } }
            )
          else
            destination.assign_attribute(
              converter_attribute.destination_attribute_dot_parts.first,
              value
            )
          end
        end

        destination
      end

      def self.attribute(destination_attribute, args = {}, &block)
        if args.key?(:destination_attribute)
          raise 'You cannot provide destination_attribute in args.  Pass the value as the first argument.'
        end

        attributes.add(
          ResourceConverter::Attribute.new(
            args.merge(
              block: (block if block_given?),
              destination_attribute: destination_attribute
            )
          )
        )
      end

      def self.attributes
        @attributes ||= ResourceConverter::AttributeSet.new(resource_converter_class: self)
      end
    end
  end
end
