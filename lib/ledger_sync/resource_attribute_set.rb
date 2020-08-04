# frozen_string_literal: true

module LedgerSync
  class ResourceAttributeSet
    include Util::Mixins::DelegateIterableMethodsMixin

    attr_reader :attributes,
                :references,
                :references_one,
                :references_many,
                :resource

    delegate_hash_methods_to :attributes

    alias names keys

    def initialize(resource:)
      @attributes = {}
      @references = []
      @references_one = []
      @references_many = []

      @resource = resource
    end

    def add(attribute)
      name = attribute.name
      raise "Attribute #{name} already exists on #{resource.name}." if attributes.key?(name)

      case attribute
      when ResourceAttribute::Reference::One
        @attributes[attribute.name] = attribute
        @references << attribute
        @references_one << attribute
      when ResourceAttribute::Reference::Many
        @attributes[attribute.name] = attribute
        @references << attribute
        @references_many << attribute
      when ResourceAttribute
        @attributes[attribute.name] = attribute
      else
        raise 'Unknown attribute class'
      end
    end

    def to_a
      attributes.values
    end

    def to_h
      attributes.transform_values(&:value)
    end
  end
end
