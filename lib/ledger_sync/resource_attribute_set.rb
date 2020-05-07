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

      if attribute.is_a?(ResourceAttribute::Reference::One)
        @attributes[attribute.name] = attribute
        @references << attribute
        @references_one << attribute
      elsif attribute.is_a?(ResourceAttribute::Reference::Many)
        @attributes[attribute.name] = attribute
        @references << attribute
        @references_many << attribute
      elsif attribute.is_a?(ResourceAttribute)
        @attributes[attribute.name] = attribute
      else
        raise 'Unknown attribute class'
      end
    end

    def to_a
      attributes.values
    end

    def to_h
      Hash[attributes.map { |k, v| [k, v.value] }]
    end
  end
end
