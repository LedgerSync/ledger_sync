# frozen_string_literal: true

require_relative 'resource_converter/attribute_set'
require_relative 'resource_converter/attribute'
Gem.find_files('ledger_sync/util/resource_converter/type/**/*.rb').each { |path| require path }

module LedgerSync
  module Util
    class ResourceConverter
      def convert(args = {})
        destination  = args.fetch(:destination).dup
        destination  = Util::HashHelpers.deep_stringify_keys(destination) if destination.is_a?(Hash)
        only_changes = args.fetch(:only_changes, false)
        source       = args.fetch(:source).dup
        source       = Util::HashHelpers.deep_stringify_keys(source) if source.is_a?(Hash)

        convertable_attributes(only_changes: only_changes, source: source).each do |converter_attribute|
          args_to_pass = {
            destination: destination,
            source: source
          }
          next if converter_attribute.if_method.present? && !send(converter_attribute.if_method, args_to_pass)

          # This is for in place changes
          destination = converter_attribute.build_destination!(args_to_pass)
        end

        destination
      end

      def convertable_attributes(args = {})
        converter_attributes = self.class.attributes
        source               = args.fetch(:source)

        return converter_attributes unless args[:only_changes] == true

        raise 'only_changes can only be passed when the source is a resource' if source.is_a?(Hash)

        converter_attributes.select { |e| source.attribute_changed?(e.source_attribute) }
      end

      def self._attribute(destination_attribute = nil, args = {}, &block)
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

      def self.attribute(*args, &block)
        _attribute(*args, &block)
      end

      def self.attributes
        @attributes ||= ResourceConverter::AttributeSet.new(resource_converter_class: self)
      end

      def self._references(destination_attribute = nil, args = {}, &block)
        reference_type     = args.fetch(:reference_type)
        resource_converter = args.fetch(:resource_converter)

        reference_type_class = case reference_type
                               when :many
                                 ResourceConverter::Type::ReferencesManyType
                               when :one
                                 ResourceConverter::Type::ReferencesOneType
                               else
                                 raise "Unkown reference type: #{references_type}"
                               end

        _attribute(
          destination_attribute,
          {
            type: reference_type_class.new(
              resource_converter: resource_converter
            )
          }.merge(
            args.except(
              %i[
                reference_type
                resource_converter
              ]
            )
          ),
          &block
        )
      end

      def self.references_one(destination_attribute = nil, args = {}, &block)
        _references(
          destination_attribute,
          {
            reference_type: :one
          }.merge(args),
          &block
        )
      end

      def self.references_many(destination_attribute = nil, args = {}, &block)
        _references(
          destination_attribute,
          {
            reference_type: :many
          }.merge(args),
          &block
        )
      end
    end
  end
end
