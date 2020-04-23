# frozen_string_literal: true

Gem.find_files('ledger_sync/type/**/*.rb').each { |path| require path }
require_relative 'serializer/attribute'
require_relative 'serializer/attribute_set'

module LedgerSync
  class Serializer
    def serialize(args = {})
      only_changes = args.fetch(:only_changes, false)
      resource     = args.fetch(:resource)

      ret = {}

      self.class.attributes.each do |serializer_attribute|
        next if only_changes && !resource.attribute_changed?(serializer_attribute.resource_attribute)

        ret = Util::HashHelpers.deep_merge(
          hash_to_merge_into: ret,
          other_hash: serializer_attribute.output_attribute_hash_for(resource: resource)
        )
      end

      ret
    end

    def self.attribute(args = {}, &block)
      output_attribute   = args.fetch(:output_attribute)
      resource_attribute = args.fetch(:resource_attribute, nil)
      type               = args.fetch(:type, nil)

      _attribute(
        block: (block if block_given?),
        output_attribute: output_attribute,
        resource_attribute: resource_attribute,
        type: type
      )
    end

    def self.attributes
      @attributes ||= Serializer::AttributeSet.new(serializer_class: self)
    end

    def self.references_many(args = {})
      _attribute(
        {
          type: Type::ReferencesManyType.new(serializer: self)
        }.merge(args)
      )
    end

    def self.references_one(args = {})
      _attribute(
        {
          type: Type::ReferencesOneType.new(serializer: self)
        }.merge(args)
      )
    end

    def self.id(args = {}, &block)
      @id ||= _attribute(
        {
          block: (block if block_given?),
          id: true
        }.merge(args)
      )
    end

    private_class_method def self._attribute(args)
      attributes.add(
        _build_attribute(args)
      )
    end

    private_class_method def self._build_attribute(args)
      block              = args.fetch(:block, nil)
      id                 = args.fetch(:id, false)
      output_attribute   = args.fetch(:output_attribute)
      resource_attribute = args.fetch(:resource_attribute, nil)
      resource_class     = args.fetch(:resource_class, nil)
      serializer         = args.fetch(:serializer, nil)
      type               = args.fetch(:type, nil)

      Serializer::Attribute.new(
        id: id,
        block: block,
        output_attribute: output_attribute,
        resource_attribute: resource_attribute,
        resource_class: resource_class,
        serializer: serializer,
        type: type
      )
    end
  end
end
